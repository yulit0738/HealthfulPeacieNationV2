package com.willneiman.HealthfulPeacieNation.entity.product;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

@Getter
@Setter
@ToString
public class ProductForm {
    @NotEmpty(message = "상품 이름을 입력해주세요.")
    private String name;
    @Min(value = 0, message = "가격은 0원 이상이어야 합니다.")
    private int price;
    @Min(value = 0, message = "재고는 0 이상이어야 합니다.")
    private int stock;
    @Min(value = 0, message = "남은 사용횟수는 0 이상이어야 합니다.")
    private int remainingUses;
    @NotEmpty
    private String category;
    private String thumbnail;
    private String image1;
    private String image2;
    private String description;

}
