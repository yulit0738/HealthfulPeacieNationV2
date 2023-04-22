package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.LoginForm;
import com.willneiman.HealthfulPeacieNation.entity.Member;
import com.willneiman.HealthfulPeacieNation.enums.LoginResult;
import com.willneiman.HealthfulPeacieNation.repository.MemberRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import static org.junit.jupiter.api.Assertions.*;


@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class MemberServiceTest {

    @Autowired MemberService memberService;
    @Autowired MemberRepository memberRepository;
    @Autowired EntityManager em;

    @Test
    public void 회원가입() throws Exception {
        //given
        Member member = createSampleMember();

        //when
        Long signupId = memberService.signup(member);

        //then
        assertEquals(member, memberService.findMember(signupId));
    }
    @Test(expected = IllegalStateException.class)
    public void 중복회원_예외() throws Exception {
        //given
        Member member1 = new Member();
        member1.setUsername("testUsername");
        Member member2 = new Member();
        member2.setUsername("testUsername");

        //when
        memberService.signup(member1);
        memberService.signup(member2);

        //then
        fail("예외가 발생해야 함");
    }

    @Test
    public void 로그인_유효성검사() throws Exception {
        //given
        Member member = createSampleMember();
        em.persist(member);
        LoginForm loginForm = new LoginForm();
        loginForm.setUsername("testId");
        loginForm.setPassword("1234");
        //when
        LoginResult loginResult = memberService.loginCheck(loginForm);
        loginResult.toString();
        //then
        assertEquals(LoginResult.LOGIN_SUCCESS, loginResult);
    }

    private static Member createSampleMember() {
        Member member = new Member();
        member.setUsername("testId");
        member.setPassword("1234");
        member.setName("testName");
        member.setPhoneNumber("010-1234-5678");
        member.setEmail("test@test.test");
        return member;
    }

}