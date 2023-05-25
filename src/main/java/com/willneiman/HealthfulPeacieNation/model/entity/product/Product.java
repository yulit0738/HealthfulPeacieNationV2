package com.willneiman.HealthfulPeacieNation.model.entity.product;

import com.willneiman.HealthfulPeacieNation.model.ProductImageInfo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.util.CollectionUtils;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.Map;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "dtype")
@Getter
@Setter
@ToString
@EntityListeners(AuditingEntityListener.class)
@Slf4j
public class Product implements IProduct {
    @Id
    @GeneratedValue
    @Column(name = "product_id")
    private Long id;

    @NotNull
    private String name;

    @NotNull
    private int price;
    @Column(columnDefinition = "int default 0")
    private double rating;
    @Column(columnDefinition = "int default 0")
    private int sales;
    private String thumbnail;
    private String image1;
    private String image2;
    private String description;
    @CreatedDate
    private LocalDateTime registrationDate;

    @Transient
    private static final String PLACE_HOLDER_IMAGE = "images/No-Image-Placeholder.png";

    @Override
    public int getStock() {
        return 0;
    }

    @Override
    public void setStock(int count) {

    }

    public static Product of(NewProductForm form, ProductImageInfo productImageInfo) {
        Product product;
        if (form.isItemProduct()) {
            product = new Item();
            product.setStock(form.getStock());
        } else if (form.isTicketProduct()) {
            product = new Ticket();
            product.setStock(form.getStock());
        } else {
            throw new IllegalArgumentException("유효하지 않은 카테고리: " + form.getCategory());
        }

        product.setName(form.getName());
        product.setPrice(form.getPrice());
        product.setDescription(form.getDescription());
        // 저장된 파일의 경로를 Product에 설정하기

        product.setThumbnail(productImageInfo.getThumbnailPath());
        product.setImage1(productImageInfo.getImagePath1());
        product.setImage2(productImageInfo.getImagePath2());
        return product;
    }

}
