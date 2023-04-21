package com.willneiman.HealthfulPeacieNation.Entity;

import javax.persistence.*;

@Entity
public class Reservation {
    @Id
    @GeneratedValue
    private String id;

    @ManyToOne(fetch = FetchType.LAZY)
    private Member member;
}
