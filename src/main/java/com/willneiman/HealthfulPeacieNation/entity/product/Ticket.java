package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("ticket")
@Getter
public class Ticket extends Product{

    @Column(columnDefinition = "int default 10")
    private int remainingUses;
}
