package com.willneiman.HealthfulPeacieNation.entity.order;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Getter
@Setter
public class OrderItemForm {

    @NotNull
    private Long id;
    @NotNull
    private int quantity;
}
