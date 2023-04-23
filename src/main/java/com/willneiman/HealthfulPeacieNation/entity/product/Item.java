package com.willneiman.HealthfulPeacieNation.entity.product;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("item")
public class Item extends Category{

    @Column(columnDefinition = "int default 0")
    private int stock;
}
