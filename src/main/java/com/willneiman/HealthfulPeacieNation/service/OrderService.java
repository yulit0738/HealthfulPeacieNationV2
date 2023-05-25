package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.order.*;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.repository.MemberRepository;
import com.willneiman.HealthfulPeacieNation.repository.OrderLineRepository;
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
    private final ProductService productService;
    private final OrderLineRepository orderLineRepository;

    public Long order(Long id, Member member, PaymentMethod paymentMethod, Integer quantity){

        Product product = productService.findProduct(id);

        // 주문서 저장
        Order order = new OrderBuilder()
                .setMember(member)
                .setTotalPrice(quantity, product.getPrice())
                .setOrderState(OrderState.PAYMENT_COMPLETED)
                .setPaymentMethod(paymentMethod)
                .build();
        Long orderId = orderRepository.save(order);

        // 주문 상품 빌더
        OrderLine orderLine = new OrderLineBuilder()
                .setOrder(order)
                .setMember(member)
                .setProduct(product)
                .setOrderPrice(quantity, product.getPrice())
                .setOrderCount(quantity)
                .build();
        orderLineRepository.save(orderLine);

        // Order에 OrderLine 추가
        order.addOrderLine(orderLine);

        // 재고 감소
        productService.adjustStock(id, quantity);

        return orderId;
    }

    public Order findOrder(Long id){
        return orderRepository.findOne(id);
    }
}
