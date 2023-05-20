package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.ShopListForm;
import com.willneiman.HealthfulPeacieNation.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class ShoppingController {

    private final ProductService productService;

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
}
