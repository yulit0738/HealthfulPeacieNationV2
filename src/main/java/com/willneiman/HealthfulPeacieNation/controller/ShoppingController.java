package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.annotation.LoginOnly;
import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.order.*;
import com.willneiman.HealthfulPeacieNation.entity.product.*;
import com.willneiman.HealthfulPeacieNation.service.OrderService;
import com.willneiman.HealthfulPeacieNation.service.ProductService;
import com.willneiman.HealthfulPeacieNation.service.RatingService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class ShoppingController {

    private final ProductService productService;
    private final RatingService ratingService;
    private final OrderService orderService;

    @GetMapping("/shopping")
    public String shopView(@RequestParam(defaultValue = "1") int page, Model model){
        Pageable pageable = PageRequest.of(page-1, 20);
        List<Product> productList = productService.findProductsByPageAndCategory(pageable, "item");

        List<ShopListForm> shopListForms = productList.stream()
                .map(product -> new ShopListForm(product))
                .collect(Collectors.toList());


        int totalPages = productService.findTotalPageByCategory("item", pageable);
        int startPage = Math.max(page - 5, 1);
        int endPage = Math.min(startPage + 9, totalPages);

        model.addAttribute("itemList", shopListForms);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentCategory", "item");
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);;

        return "/shopping/shop";
    }

    @GetMapping("/shopping/detail/{id}")
    public String shopDetailView(@PathVariable Long id, Model model){
        Item item = (Item)productService.findProduct(id);
        Map<String, Object> ratingData = ratingService.calculateRating(item);
        ItemDetailForm itemDetailForm = new ItemDetailForm(item, "item");

        model.addAttribute("item", itemDetailForm);
        model.addAllAttributes(ratingData);

        return "/shopping/shopdetail";
    }

    @PostMapping("/shopping/add-cart/{id}")
    @LoginOnly
    public String shopAddCart(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes){
        Item item = (Item)productService.findProduct(id);
        // 장바구니 추가 로직
        redirectAttributes.addFlashAttribute("cartMessage", "상품이 장바구니에 담겼습니다!");

        return "redirect:/shopping/detail/" + id;
    }
}
