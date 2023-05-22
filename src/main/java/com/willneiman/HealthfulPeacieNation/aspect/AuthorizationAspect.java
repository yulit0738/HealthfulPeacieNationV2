package com.willneiman.HealthfulPeacieNation.aspect;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Aspect
@Component
public class AuthorizationAspect {

    @Around("@annotation(com.willneiman.HealthfulPeacieNation.annotation.AdminOnly)")
    public Object checkAdminAccess(ProceedingJoinPoint joinPoint) throws Throwable {
        // 세션에서 로그인 정보 확인
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        Member member = (Member) session.getAttribute("member");

        // 관리자 여부 확인
        if (member == null || !member.getUsername().equals("admin")) {
            // 로그인 아이디가 'admin'이 아닌 경우, 이전 페이지로 리다이렉트
            String referer = request.getHeader("Referer");
            if (referer != null) {
                return "redirect:" + referer;
            } else {
                // 이전 페이지 정보가 없는 경우, 기본 페이지로 리다이렉트
                return "redirect:/";
            }
        }

        // 조건 충족 시 그대로 진행 타겟 메소드 호출
        return joinPoint.proceed();
    }
    @Around("@annotation(com.willneiman.HealthfulPeacieNation.annotation.LoginOnly)")
    public Object checkLoginAccess(ProceedingJoinPoint joinPoint) throws Throwable {
        // 세션에서 로그인 정보 확인
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        Member member = (Member) session.getAttribute("member");

        // 관리자 여부 확인
        if (member == null) {
            // 로그인 세션이 없을 경우 이전 페이지로 리다이렉트
            String referer = request.getHeader("Referer");
            if (referer != null) {
                return "redirect:" + referer;
            } else {
                // 이전 페이지 정보가 없는 경우, 기본 페이지로 리다이렉트
                return "redirect:/";
            }
        }

        // 조건 충족 시 그대로 진행 타겟 메소드 호출
        return joinPoint.proceed();
    }
}
