package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.entity.LoginForm;
import com.willneiman.HealthfulPeacieNation.entity.Member;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final MemberService memberService;

    /*
    로그인 페이지 불러오기
     */
    @GetMapping("/login")
    public String login(Model model, HttpSession session, HttpServletRequest request){
        // 이미 세션에 로그인 정보가 있을 경우 이전 페이지로 돌려보내기
        if(session.getAttribute("member") != null){
            String referer = request.getHeader("Referer");
            return "redirect:" + (referer != null ? referer : "/");
        }
        return "members/login";
    }

    @PostMapping("/login")
    public String processLogin(@Valid @ModelAttribute("loginForm") LoginForm form, BindingResult result,
                               Model model, HttpSession session, HttpServletRequest request){
        if(session.getAttribute("member") != null){
            String referer = request.getHeader("Referer");
            return "redirect:" + (referer != null ? referer : "/");
        }
        if(result.hasErrors()){
            return "members/login";
        }
        //로그인 처리
        Member member = memberService.login(form);
        if(member == null){
            //에러 메시지
            model.addAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "members/login";
        }
        session.setAttribute("member", member);
        System.out.println("login session = " + session);
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request){
        if(session.getAttribute("member") == null){
            // 로그인 세션이 없는 경우 직전에 보던 페이지로 redirect
            String referer = request.getHeader("Referer");
            if(referer != null){
                return "redirect:" + referer;
            } else {
                // 세션이 있지만 직전 페이지 정보가 없는 경우 홈페이지로
                return "redirect:/";
            }
        } // 세션 만료 후 홈페이지로
        session.removeAttribute("member");
        return "redirect:/";
    }
}
