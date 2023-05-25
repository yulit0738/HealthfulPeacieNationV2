package com.willneiman.HealthfulPeacieNation.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductImageInfo {
    // 일부러 JSON파싱시의 MAP의 KEY값과 변수명을 다르게 줌 그래도 값 들어감
    @JsonProperty(value = "thumbnail")
    private String thumbnailPath;
    private String imagePath1;
    private String imagePath2;
}
