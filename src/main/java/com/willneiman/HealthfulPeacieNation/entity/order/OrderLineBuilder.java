package com.willneiman.HealthfulPeacieNation.entity.order;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;

public class OrderLineBuilder {
    private Order order;
    private Member member;
    private Product product;
    private int orderPrice;
    private int orderCount;

    public OrderLineBuilder setOrder(Order order) {
        this.order = order;
        return this;
    }

    public OrderLineBuilder setMember(Member member) {
        this.member = member;
        return this;
    }

    public OrderLineBuilder setProduct(Product product) {
        this.product = product;
        return this;
    }

    public OrderLineBuilder setOrderPrice(int price) {
        this.orderPrice = price;
        return this;
    }

    public OrderLineBuilder setOrderCount(int orderCount) {
        this.orderCount = orderCount;
        return this;
    }

    public OrderLine build() {
        OrderLine orderLine = new OrderLine();
        orderLine.setOrder(order);
        orderLine.setMember(member);
        orderLine.setProduct(product);
        orderLine.setOrderPrice(orderPrice);
        orderLine.setOrderCount(orderCount);
        orderLine.setTotalPrice();
        return orderLine;
    }
}
