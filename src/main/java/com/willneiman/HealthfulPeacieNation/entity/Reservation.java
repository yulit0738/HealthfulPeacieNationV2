package com.willneiman.HealthfulPeacieNation.entity;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;

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
