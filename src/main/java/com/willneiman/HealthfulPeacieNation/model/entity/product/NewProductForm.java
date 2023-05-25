package com.willneiman.HealthfulPeacieNation.model.entity.product;

import com.willneiman.HealthfulPeacieNation.model.enums.ItemCategory;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@ToString
public class NewProductForm {
    @NotEmpty(message = "상품 이름을 입력해주세요.")
    private String name;
    @Min(value = 0, message = "가격은 0원 이상이어야 합니다.")
    private int price;
    @Min(value = 0, message = "재고는 0 이상이어야 합니다.")
    private int stock;
    @Min(value = 0, message = "남은 사용횟수는 0 이상이어야 합니다.")
    private int remainingUses;
    @NotNull
    private ItemCategory category;
    private String description;
    private MultipartFile thumbnail;
    private MultipartFile image1;
    private MultipartFile image2;

    public boolean isItemProduct() {
        return category != null && category.isItem();
    }

    public boolean isTicketProduct() {
        return category != null && category.isTicket();
    }
}
