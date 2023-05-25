package com.willneiman.HealthfulPeacieNation.entity.order;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import lombok.Setter;
import org.aspectj.weaver.ast.Or;
import org.springframework.data.jpa.domain.AbstractAuditable;

public class OrderBuilder {

    private Member member;
    private int totalPrice;
    private OrderState state;
    private PaymentMethod paymentMethod;

    public OrderBuilder setMember(Member member){
        this.member = member;
        return this;
    }

    public OrderBuilder setTotalPrice(int quantity, int price){
        this.totalPrice = quantity * price;
        return this;
    }

    public OrderBuilder setOrderState(OrderState state){
        this.state = state;
        return this;
    }

    public OrderBuilder setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
        return this;
    }

    public Order build(){
        Order order = new Order();
        order.setMember(member);
        order.setTotalPrice(totalPrice);
        order.setStatus(state);
        order.setPaymentMethod(paymentMethod);
        return order;
    }

}
