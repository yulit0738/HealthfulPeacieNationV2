package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("item")
@Getter @Setter
public class Item extends Product{

    @Column(columnDefinition = "int default 0")
    private int stock;
}
