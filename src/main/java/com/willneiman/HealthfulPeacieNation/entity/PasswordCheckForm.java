package com.willneiman.HealthfulPeacieNation.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotEmpty;

@Getter @Setter
@ToString
public class PasswordCheckForm {

    private String username;
    @NotEmpty(message = "비밀번호를 입력해주세요.")
    private String password;
}
