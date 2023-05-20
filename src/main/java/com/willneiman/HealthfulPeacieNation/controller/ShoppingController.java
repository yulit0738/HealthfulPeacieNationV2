package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class ShoppingController {

    private final ProductService productService;

    @GetMapping("/shoppging/Items")
    public String shopView(){
        return "";
    }
}
