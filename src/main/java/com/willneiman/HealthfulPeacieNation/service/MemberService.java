package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.LoginForm;
import com.willneiman.HealthfulPeacieNation.entity.Member;
import com.willneiman.HealthfulPeacieNation.enums.LoginResult;
import com.willneiman.HealthfulPeacieNation.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    // 회원가입
    public Long signup(Member member){
        validateDuplicateMember(member);
        return memberRepository.save(member);
    }

    // 아이디로 회원 조회
    public Member findMember(Long id){
        return memberRepository.findOne(id);
    }

    // 아이디 유효성 검사
    public void validateDuplicateMember(Member member){
        Member findMember = memberRepository.findByUsername(member.getUsername());
        if(findMember != null){
            throw new IllegalStateException("이미 가입된 아이디입니다");
        }
    }

    // 로그인
    public LoginResult loginCheck(LoginForm form){
        Member member = memberRepository.findByUsername(form.getUsername());
        if(member == null || !member.getPassword().equals(form.getPassword())) {
            return LoginResult.LOGIN_FAILED;
        }
        return LoginResult.LOGIN_SUCCESS;
    }
}
