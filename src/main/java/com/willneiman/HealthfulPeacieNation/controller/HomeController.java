package com.willneiman.HealthfulPeacieNation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model, HttpSession session){
        if(session.getAttribute("signupSuccess") != null) {
            model.addAttribute("signupSuccess", true);
            session.removeAttribute("signupSuccess");
        }
        return "home/home";
    }
}
