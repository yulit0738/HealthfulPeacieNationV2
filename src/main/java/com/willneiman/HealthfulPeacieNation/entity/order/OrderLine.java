package com.willneiman.HealthfulPeacieNation.entity.order;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

import static javax.persistence.FetchType.*;

@Entity
@Getter @Setter
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

    private int orderPrice;

    private int orderCount;

    private int totalPrice;

    private int rating;

    // 주문 상품의 총 가격
    public void setTotalPrice(){
        this.totalPrice = orderPrice * orderCount;
    }
}
