package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "dtype")
@Getter @Setter
@ToString
@EntityListeners(AuditingEntityListener.class)
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
    @Column(columnDefinition = "int default 0")
    private int sales;
    private String thumbnail;
    private String image1;
    private String image2;
    private String description;
    @CreatedDate
    private LocalDateTime registrationDate;

}
