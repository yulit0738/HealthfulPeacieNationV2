package com.willneiman.HealthfulPeacieNation.entity;

import javax.persistence.*;

import static javax.persistence.FetchType.*;

@Entity
public class MemberQuestion {

    @Id @GeneratedValue
    private String id;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    private String question;

    private String answer;
}
