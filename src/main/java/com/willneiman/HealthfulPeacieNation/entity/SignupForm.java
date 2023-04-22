package com.willneiman.HealthfulPeacieNation.entity;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Getter @Setter
public class SignupForm {

    @NotEmpty(message = "아이디를 입력해주세요.")
    private String username;
    @NotEmpty(message = "비밀번호를 입력해주세요.")
    private String password;
    @NotEmpty(message = "이름을 입력해주세요.")
    private String name;
    @NotEmpty(message = "전화번호를 입력해주세요.")
    private String phoneNumber;
    @NotEmpty(message = "메일주소를 입력해주세요.")
    private String email;
}
