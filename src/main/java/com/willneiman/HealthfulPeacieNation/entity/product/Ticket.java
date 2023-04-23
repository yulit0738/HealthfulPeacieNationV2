package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("ticket")
@Getter
public class Ticket extends Category{
}
