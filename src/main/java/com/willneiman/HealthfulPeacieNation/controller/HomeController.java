package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.entity.LoginForm;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model, HttpSession session){
        // signup 성공 시 전달받은 세션. 가입 축하메시지 전용
        if(session.getAttribute("signupSuccess") != null) {
            model.addAttribute("signupSuccess", true);
            session.removeAttribute("signupSuccess");
        }
        return "home/home";
    }
}
