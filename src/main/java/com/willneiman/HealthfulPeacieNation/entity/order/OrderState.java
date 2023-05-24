package com.willneiman.HealthfulPeacieNation.entity.order;

public enum OrderState {
    ORDER_RECEIVED, // 주문접수
    PAYMENT_COMPLETED, // 결제완료
    PREPARING_SHIPMENT, // 배송준비
    SHIPPING, // 배송중
    DELIVERED, // 배송완료
    EXCHANGE, // 교환
    REFUND // 환불
}
