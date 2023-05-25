package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.annotation.LoginOnly;
import com.willneiman.HealthfulPeacieNation.model.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.model.entity.member.MyInformationForm;
import com.willneiman.HealthfulPeacieNation.model.entity.member.PasswordCheckForm;
import com.willneiman.HealthfulPeacieNation.model.entity.order.Order;
import com.willneiman.HealthfulPeacieNation.model.entity.order.OrderLine;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import com.willneiman.HealthfulPeacieNation.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class MypageController {

    private final MemberService memberService;
    private final OrderService orderService;

    @GetMapping("/my/info")
    @LoginOnly
    public String mypagePasswordCheckView(Model model, HttpSession session) {
        Boolean passwordCheck = (Boolean) session.getAttribute("passwordCheck");
        // 비밀번호 검증을 하지 않은 채로 요청 시
        if(session.getAttribute("passwordCheck") == null || passwordCheck == false){
            return "mypage/myinfopwcheck";
        }
        // 비밀번호 검증을 이미 진행한 경우 생략
        Member loginMember = (Member) session.getAttribute("member");
        Long id = loginMember.getId();
        Member member = memberService.findMember(id);
        MyInformationForm form =
                new MyInformationForm(member.getId(), member.getUsername(),
                member.getPassword(),member.getName(), member.getPhoneNumber(),
                member.getEmail(), member.getRegistrationDate());
        model.addAttribute("informationForm", form);
        return "mypage/myinfo";
    }

    @PostMapping("/my/info")
    @LoginOnly
    public String mypagePasswordCheck(@Valid @ModelAttribute("passwordCheckForm") PasswordCheckForm form, BindingResult result,
                                      Model model, HttpSession session) {
        Member member = (Member)session.getAttribute("member");
        form.setUsername(member.getUsername());

        // 비밀번호를 입력하지 않았을 경우 돌려보내기
        if(result.hasErrors()){
            return "redirect:/my/info";
        }
        //로그인 처리
        if(!memberService.checkPassword(form.getPassword(), member.getPassword())){
            session.setAttribute("passwordCheck", false);
            model.addAttribute("errorMessage", "비밀번호가 잘못되었습니다.");
            return "redirect:/my/info";
        }
        session.setAttribute("passwordCheck", true);
        return "redirect:/my/info";
    }

    @PostMapping("/my/info/modify")
    @LoginOnly
    public String modifyInformation(HttpSession session, MyInformationForm form) {
        memberService.modifyMember(form);
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
    public String mypageOrdersView(HttpSession session, Model model){
        Member member = (Member)session.getAttribute("member");
        List<Order> orderList = orderService.orderListByMember(member.getId());

        for(Order order : orderList) {
            List<OrderLine> orderLines = orderService.findOrderLinesByOrderId(order.getId());
            order.setOrderLines(orderLines);
        }

        model.addAttribute("orderList", orderList);
        return "mypage/myorders";
    }

    @GetMapping("my/cart")
    @LoginOnly
    public String mypageCartView(){
        return "mypage/mycart";
    }

    @GetMapping("my/reviews")
    @LoginOnly
    public String mypageReviewsView(){
        return "mypage/myreviews";
    }

    @GetMapping("my/tickets")
    @LoginOnly
    public String mypageTicketsView(){
        return "mypage/mytickets";
    }

    @GetMapping("my/reservations")
    @LoginOnly
    public String mypageReservationView(){
        return "mypage/myreservations";
    }

    @GetMapping("my/questions")
    @LoginOnly
    public String mypageQuestionsView(){
        return "mypage/myquestions";
    }
}
