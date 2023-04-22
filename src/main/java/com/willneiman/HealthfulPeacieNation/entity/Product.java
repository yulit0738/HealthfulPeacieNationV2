package com.willneiman.HealthfulPeacieNation.entity;

import lombok.Getter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@Getter
public class Product {

    @Id @GeneratedValue
    @Column(name = "product_id")
    private Long id;

    private String name;
    private int price;
    private int stock;
    private double rating;
    private int sales;
    private String category;
    private String thumbnail;
    private String image1;
    private String image2;

}
