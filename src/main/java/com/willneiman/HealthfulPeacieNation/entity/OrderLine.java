package com.willneiman.HealthfulPeacieNation.entity;

import com.willneiman.HealthfulPeacieNation.entity.product.Product;

import javax.persistence.*;

import static javax.persistence.FetchType.*;

@Entity
public class OrderLine {
    @Id
    @GeneratedValue
    private String id;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "product_id")
    private Product product;
}
