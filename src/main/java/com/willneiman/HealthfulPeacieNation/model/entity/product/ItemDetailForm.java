package com.willneiman.HealthfulPeacieNation.model.entity.product;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemDetailForm {
    private Long id;
    private String name;
    private Integer price;
    private Double rating;
    private Integer inventory;
    private String thumbnail;
    private String image1;
    private String image2;
    private String description;

    public ItemDetailForm(Product product, String category) {
        this.id = product.getId();
        this.name = product.getName();
        this.thumbnail = product.getThumbnail();
        this.price = product.getPrice();
        this.rating = product.getRating();
        this.image1 = product.getImage1();
        this.image2 = product.getImage2();
        this.description = product.getDescription();
        this.inventory = ((Item) product).getStock();
    }

}
