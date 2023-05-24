package com.willneiman.HealthfulPeacieNation.entity.order;

public enum PaymentMethod {
    CREDIT_CARD("신용카드"), //신용카드
    CASH("무통장입금"), //현금
    VIRTUAL_ACCOUNT("가상계좌"), //가상계좌
    POINT("포인트"), //포인트
    KAKAO_PAY("카카오페이"), // 카카오페이
    TOSS_PAY("토스페이"); //토스페이

    private String description;

    PaymentMethod(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
