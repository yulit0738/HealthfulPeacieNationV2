package com.willneiman.HealthfulPeacieNation.Entity;

import javax.persistence.*;

import static javax.persistence.FetchType.*;

@Entity
public class OrderLine {
    @Id
    @GeneratedValue
    private String id;

    @ManyToOne(fetch = LAZY)
    @Column(name = "order_id")
    private Order order;

    @ManyToOne(fetch = LAZY)
    @Column(name = "member_id")
    private Member member;

    @ManyToOne(fetch = LAZY)
    @Column(name = "product_id")
    private Product product;
}
