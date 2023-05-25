package com.willneiman.HealthfulPeacieNation.controller.advice;

import com.willneiman.HealthfulPeacieNation.model.entity.member.LoginForm;
import com.willneiman.HealthfulPeacieNation.model.entity.member.PasswordCheckForm;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.text.NumberFormat;
import java.text.DecimalFormat;

import javax.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalControllerAdvice {

    // 비로그인 시, 전역에 loginForm 세션 추가
    @ModelAttribute("loginForm")
    public LoginForm loginForm(HttpSession session){
        if(session.getAttribute("member") == null){
            return new LoginForm();
        }
        return null;
    }

    // 로그인시, 전역에 passwordCheckForm 세션 추가
    @ModelAttribute("passwordCheckForm")
    public PasswordCheckForm passwordCheckForm(HttpSession session){
        if(session.getAttribute("member") != null){
            return new PasswordCheckForm();
        }
        return null;
    }

    @ModelAttribute("numberFormat")
    public NumberFormat getNumberFormat() {
        return new DecimalFormat("#,###");
    }
}
