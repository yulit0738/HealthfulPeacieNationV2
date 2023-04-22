package com.willneiman.HealthfulPeacieNation.entity;

import javax.persistence.*;

@Entity
public class Reservation {
    @Id
    @GeneratedValue
    @Column(name = "reservation_id")
    private String id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;
}