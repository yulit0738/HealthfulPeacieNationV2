package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.order.Order;
import com.willneiman.HealthfulPeacieNation.entity.order.OrderLine;
import com.willneiman.HealthfulPeacieNation.entity.order.PaymentMethod;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class OrderServiceTest {

    @Autowired
    MemberService memberService;
    @Autowired
    OrderService orderService;
    @Autowired
    ProductService productService;
    @Autowired
    EntityManager em;

    @Test
    public void 주문하기_전체() throws Exception {
        // Given
        Long memberId = 1L;
        Long productId = 2L;
        PaymentMethod paymentMethod = PaymentMethod.CASH;
        int quantity = 1;

        Member member = memberService.findMember(memberId);

        // When
        Long orderId = orderService.order(productId, member, paymentMethod, quantity);

        // Then
        Order order = orderService.findOrder(orderId);
        System.out.println("order.getId() = " + order.getId());

        assertEquals(memberId, order.getMember().getId());
        assertEquals(paymentMethod, order.getPaymentMethod());
        assertNotNull(order.getTotalPrice());
        assertTrue(order.getTotalPrice() > 0);

        OrderLine orderLine = order.getOrderLines().get(0);
        assertEquals(productId, orderLine.getProduct().getId());
        assertEquals(quantity, orderLine.getOrderCount());

    }


}