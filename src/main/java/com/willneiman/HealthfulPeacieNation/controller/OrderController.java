package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;

}
