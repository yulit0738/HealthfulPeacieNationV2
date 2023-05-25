package com.willneiman.HealthfulPeacieNation.model.enums;


import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum ItemCategory {
    ITEM("ITEM", "헬스용품을 나타냅니다."),
    TICKET("TICKET", "헬창PT권을 나타내기위한 타입");

    private final String name;
    private final String description;

    public boolean isItem() {
        return this == ITEM;
    }

    public boolean isTicket() {
        return this == TICKET;
    }
}
