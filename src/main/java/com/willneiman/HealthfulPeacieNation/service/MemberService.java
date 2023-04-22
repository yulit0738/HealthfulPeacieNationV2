package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.LoginForm;
import com.willneiman.HealthfulPeacieNation.entity.Member;
import com.willneiman.HealthfulPeacieNation.enums.LoginResult;
import com.willneiman.HealthfulPeacieNation.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    // 회원가입
    public Long signup(Member member){
        validateDuplicateMember(member);
        member.setPassword(hashPassword(member.getPassword()));
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
    public LoginResult loginCheck(LoginForm form) {
        Member member = memberRepository.findByUsername(form.getUsername());
        // 암호화된 비밀번호와 입력 비밀번호 비교 검증
        if (member == null || !checkPassword(form.getPassword(), member.getPassword())) {
            return LoginResult.LOGIN_FAILED;
        }
        return LoginResult.LOGIN_SUCCESS;
    }

    // 비밀번호 암호화
    public String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

    // 비밀번호 검증
    public boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

}
