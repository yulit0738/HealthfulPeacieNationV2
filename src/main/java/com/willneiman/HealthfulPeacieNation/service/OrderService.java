package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
}
