package com.willneiman.HealthfulPeacieNation.entity.order;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import java.time.LocalDateTime;

public class OrderItemForm {

    private Member member;

    private int totalPrice;

    private PaymentMethod paymentMethod;

    private OrderState status;

    private LocalDateTime orderDate;
}
