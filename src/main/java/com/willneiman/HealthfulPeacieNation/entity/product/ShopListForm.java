package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ShopListForm {

    private Long id;
    private String name;
    private String thumbnail;
    private Integer price;
    private Integer inventory;

    public ShopListForm(Product product) {
        this.id = product.getId();
        this.name = product.getName();
        this.thumbnail = product.getThumbnail();
        this.price = product.getPrice();
        this.inventory = ((Item) product).getStock();
    }
}