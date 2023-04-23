package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "product_type")
@Getter
public abstract class Category {

    @Id @GeneratedValue
    @Column(name = "category_id")
    private Long id;

    @NotNull String name;
}
