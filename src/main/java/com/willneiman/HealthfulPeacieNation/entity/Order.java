package com.willneiman.HealthfulPeacieNation.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.AbstractAuditable;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;

import static javax.persistence.EnumType.*;
import static javax.persistence.FetchType.*;

@Entity
@Getter
//@Setter
@NoArgsConstructor
//@ToString
@EntityListeners(AuditingEntityListener.class)
@Table(name = "orders")
public class Order extends AbstractAuditable<Member, Long> {

    @Id @GeneratedValue
    @Column(name = "order_id")
    private Long id;

    @ManyToOne(fetch = LAZY)
    private Member member;

    private int totalPrice;

    @Enumerated(STRING)
    private PaymentMethod paymentMethod;

    @Enumerated(STRING)
    private OrderState status;

    @CreatedDate
    private LocalDateTime orderDate;
}
