package com.willneiman.HealthfulPeacieNation.model.entity.order;

import com.willneiman.HealthfulPeacieNation.model.entity.member.Member;

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
