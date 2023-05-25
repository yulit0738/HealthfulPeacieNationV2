package com.willneiman.HealthfulPeacieNation.model.entity.order;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Getter
@Setter
public class OrderItemForm {

    @NotNull
    private Long id;
    @NotNull
    private int quantity;
}
