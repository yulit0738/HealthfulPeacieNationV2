package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.entity.LoginForm;
import com.willneiman.HealthfulPeacieNation.enums.LoginResult;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String login(Model model){
        model.addAttribute("loginForm", new LoginForm());
        return "members/login";
    }

    @PostMapping("/login/pro")
    public String processLogin(@Valid @ModelAttribute("loginForm") LoginForm form,
                               BindingResult result, Model model){
        if(result.hasErrors()){
            return "members/login";
        }
        //로그인 처리
        if(memberService.loginCheck(form) == LoginResult.LOGIN_FAILED){
            //에러 메시지
            model.addAttribute("errorMessage", "아이디 혹은 비밀번호가 일치하지 않습니다.");
            return "members/login";
        }
        return "redirect:/";
    }
}
