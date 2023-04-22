package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.entity.Member;
import com.willneiman.HealthfulPeacieNation.entity.SignupForm;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class SignupController {

    private final MemberService memberService;

    @GetMapping("/signup")
    public String signup(Model model) {
        model.addAttribute("signupForm", new SignupForm());
        return "/members/signup";
    }

    @PostMapping("/signup/pro")
    public String processSignup(@Valid @ModelAttribute("signupForm") SignupForm form,
                                BindingResult result, HttpSession session){
        if(result.hasErrors()){
            return "members/signup";
        }
        // 회원가입 처리
        Member member = new Member();
        member.setUsername(form.getUsername());
        member.setPassword(form.getPassword());
        member.setName(form.getName());
        member.setPhoneNumber(form.getPhoneNumber());
        member.setEmail(form.getEmail());

        memberService.signup(member);
        session.setAttribute("signupSuccess", true);
        return "redirect:/";
    }
}
