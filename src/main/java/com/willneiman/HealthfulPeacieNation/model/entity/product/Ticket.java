package com.willneiman.HealthfulPeacieNation.model.entity.product;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;

@Entity
@DiscriminatorValue("ticket")
@Getter
@Setter
public class Ticket extends Product {

    private int remainingUses;

    @Override
    public int getStock() {
        return remainingUses;
    }

    @Override
    public void setStock(int count) {
        this.remainingUses = count;
    }
}
