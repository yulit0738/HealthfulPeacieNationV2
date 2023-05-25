package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.annotation.LoginOnly;
import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.order.PaymentMethod;
import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.service.OrderService;
import com.willneiman.HealthfulPeacieNation.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;
    private final ProductService productService;

    @GetMapping("/shopping/order/{id}")
    @LoginOnly
    public String orderView(@PathVariable Long id, Model model) {
        Item item = (Item)productService.findProduct(id);
        model.addAttribute("item", item);
        model.addAttribute("paymentMethods", PaymentMethod.values());
        return "shopping/order";
    }

    @PostMapping("/shopping/order")
    @LoginOnly
    public String order(@RequestParam("id")Long id,
                        @RequestParam PaymentMethod paymentMethod,
                        @RequestParam Integer quantity,
                        HttpSession session) {
        Member member = (Member) session.getAttribute("member");
//TODO 주문 수량, 재고 수량 조정, 주문 상태에 대한 유효성 검사 필요
        orderService.order(id, member, paymentMethod, quantity);

        return "redirect:/my/orders";
    }

}
