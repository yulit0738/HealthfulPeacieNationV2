package com.willneiman.HealthfulPeacieNation.model.entity.product;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("item")
@Getter
@Setter
public class Item extends Product {
    private int stock;

    @Override
    public int getStock() {
        return stock;
    }

    @Override
    public void setStock(int count) {
        this.stock = count;
    }
}
