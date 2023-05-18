package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("item")
@Getter @Setter
public class Item extends Product{

    private int stock;
}
