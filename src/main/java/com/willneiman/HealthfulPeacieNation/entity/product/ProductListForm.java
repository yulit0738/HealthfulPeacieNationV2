package com.willneiman.HealthfulPeacieNation.entity.product;

import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductListForm {

    private Long id;
    private String name;
    private String thumbnail;
    private Integer price;
    private Double rating;
    private Integer sales;
    private Integer inventory;

    public ProductListForm(Product product, String category) {
        this.id = product.getId();
        this.name = product.getName();
        this.thumbnail = product.getThumbnail();
        this.price = product.getPrice();
        this.rating = product.getRating();
        this.sales = product.getSales();

        if (category.equals("item")) {
            this.inventory = ((Item) product).getStock();
        } else if (category.equals("ticket")) {
            this.inventory = ((Ticket) product).getRemainingUses();
        }
    }
}