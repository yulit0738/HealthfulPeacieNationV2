package com.willneiman.HealthfulPeacieNation.entity.member;

import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@Getter
@Setter
public class MyInformationForm {

    private Long id;
    private String username;
    private String password;
    private String name;
    private String phoneNumber;
    private String email;
    private String registrationDate;

    public MyInformationForm(Long id, String username, String password, String name, String phoneNumber, String email, LocalDateTime registrationDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 a hh:mm", Locale.KOREA);

        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.registrationDate = formatter.format(registrationDate);
    }
}
