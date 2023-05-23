package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.annotation.LoginOnly;
import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.member.MyInformationForm;
import com.willneiman.HealthfulPeacieNation.entity.member.PasswordCheckForm;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class MypageController {

    private final MemberService memberService;

    @GetMapping("/my/info")
    @LoginOnly
    public String mypagePasswordCheckView(Model model, HttpSession session) {
        Boolean passwordCheck = (Boolean) session.getAttribute("passwordCheck");
        // 비밀번호 검증을 하지 않은 채로 요청 시
        if(session.getAttribute("passwordCheck") == null || passwordCheck == false){
            return "members/myinfopwcheck";
        }
        // 비밀번호 검증을 이미 진행한 경우 생략
        Member member = (Member) session.getAttribute("member");
        MyInformationForm form =
                new MyInformationForm(member.getId(), member.getUsername(),
                member.getPassword(),member.getName(), member.getPhoneNumber(),
                member.getEmail(), member.getRegistrationDate());
        model.addAttribute("informationForm", form);
        return "members/myinfo";
    }

    @PostMapping("/my/info")
    @LoginOnly
    public String mypagePasswordCheck(@Valid @ModelAttribute("passwordCheckForm") PasswordCheckForm form, BindingResult result,
                                      Model model, HttpSession session) {
        Member member = (Member)session.getAttribute("member");
        form.setUsername(member.getUsername());

        // 비밀번호를 입력하지 않았을 경우 돌려보내기
        if(result.hasErrors()){
            return "/my/info";
        }
        //로그인 처리
        if(!memberService.checkPassword(form.getPassword(), member.getPassword())){
            session.setAttribute("passwordCheck", false);
            model.addAttribute("errorMessage", "비밀번호가 잘못되었습니다.");
            return "/my/info";
        }
        session.setAttribute("passwordCheck", true);
        return "redirect:/my/info";
    }

    @PostMapping("/my/info/withdraw")
    @LoginOnly
    public String withdraw(@RequestParam Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 정상적으로 완료되었습니다.");
        memberService.withdraw(id);
        session.removeAttribute("member");
        return "redirect:/";
    }

    @GetMapping("my/orders")
    @LoginOnly
    public String mypageOrdersView(){
        return "members/myorders";
    }

    @GetMapping("my/cart")
    @LoginOnly
    public String mypageCartView(){
        return "members/mycart";
    }

    @GetMapping("my/reviews")
    @LoginOnly
    public String mypageReviewsView(){
        return "members/myreviews";
    }

    @GetMapping("my/tickets")
    @LoginOnly
    public String mypageTicketsView(){
        return "members/mytickets";
    }

    @GetMapping("my/reservations")
    @LoginOnly
    public String mypageReservationView(){
        return "members/myreservations";
    }

    @GetMapping("my/questions")
    @LoginOnly
    public String mypageQuestionsView(){
        return "members/myquestions";
    }
}