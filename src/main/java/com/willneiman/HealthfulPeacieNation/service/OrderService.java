package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.repository.MemberRepository;
import com.willneiman.HealthfulPeacieNation.repository.OrderRepository;
import com.willneiman.HealthfulPeacieNation.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final MemberRepository memberRepository;
    private final ProductRepository productRepository;

}
