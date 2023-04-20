package com.willneiman.HealthfulPeacieNation.Entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
//@Setter
@NoArgsConstructor
//@ToString
public class Order {

    @Id @GeneratedValue
    @Column(name = "order_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;

    private int totalPrice;

    private String paymentMethod;

    @Enumerated(EnumType.STRING)
    private OrderState status;

    private LocalDateTime orderDate;

}
