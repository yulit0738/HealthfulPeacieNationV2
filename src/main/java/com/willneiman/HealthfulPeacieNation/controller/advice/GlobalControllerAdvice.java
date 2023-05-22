package com.willneiman.HealthfulPeacieNation.controller.advice;

import com.willneiman.HealthfulPeacieNation.entity.LoginForm;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.text.NumberFormat;
import java.text.DecimalFormat;

import javax.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalControllerAdvice {

    @ModelAttribute("loginForm")
    public LoginForm loginForm(HttpSession session){
        if(session.getAttribute("member") == null){
            return new LoginForm();
        }
        return null;
    }

    @ModelAttribute("numberFormat")
    public NumberFormat getNumberFormat() {
        return new DecimalFormat("#,###");
    }
}
