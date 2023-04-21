package com.willneiman.HealthfulPeacieNation.Entity;

import javax.persistence.*;

import static javax.persistence.FetchType.*;

@Entity
public class MemberQuestion {

    @Id @GeneratedValue
    private String id;

    @ManyToOne(fetch = LAZY)
    private Member member;
}
