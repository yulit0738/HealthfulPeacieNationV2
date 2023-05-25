package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.model.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.model.entity.order.Order;
import com.willneiman.HealthfulPeacieNation.model.entity.order.OrderLine;
import com.willneiman.HealthfulPeacieNation.model.entity.order.PaymentMethod;
import com.willneiman.HealthfulPeacieNation.model.entity.product.Item;
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

        System.out.println("member.getId() = " + member.getId());
        // When
        int stockBeforeOrder = ((Item)productService.findProduct(productId)).getStock();
        System.out.println("stockBeforeOrder = " + stockBeforeOrder);
        Long orderId = orderService.order(productId, member, paymentMethod, quantity);
        System.out.println("When orderId = " + orderId);

        // Then
        Order order = orderService.findOrder(orderId);
        System.out.println("Then order.getId() = " + order.getId());
        System.out.println("order.getOrderLines().get(0).getOrderCount() = " + order.getOrderLines().get(0).getOrderCount());
        int stockAfterOrder = (((Item)order.getOrderLines().get(0).getProduct()).getStock());
        System.out.println("stockAfterOrder = " + stockAfterOrder);

        assertEquals(memberId, order.getMember().getId());
        assertEquals(paymentMethod, order.getPaymentMethod());
        assertNotNull(order.getTotalPrice());
        assertTrue(order.getTotalPrice() > 0);

        OrderLine orderLine = order.getOrderLines().get(0);
        assertEquals(productId, orderLine.getProduct().getId());
        assertEquals(quantity, orderLine.getOrderCount());

    }


}