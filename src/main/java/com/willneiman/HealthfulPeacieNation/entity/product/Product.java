package com.willneiman.HealthfulPeacieNation.entity.product;

import com.willneiman.HealthfulPeacieNation.entity.product.Category;
import lombok.Getter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;

@Entity
@Getter
public class Product {

    @Id @GeneratedValue
    @Column(name = "product_id")
    private Long id;

    @NotNull
    private String name;
    @NotNull
    private int price;
    @Column(columnDefinition = "int default 0")
    private double rating;
    private int sales;
    private Category category;
    private String thumbnail;
    private String image1;
    private String image2;

}
