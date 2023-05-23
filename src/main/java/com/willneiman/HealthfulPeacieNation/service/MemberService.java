package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.member.LoginForm;
import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import com.willneiman.HealthfulPeacieNation.entity.member.MyInformationForm;
import com.willneiman.HealthfulPeacieNation.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MemberService {

    private final MemberRepository memberRepository;

    // 회원가입
    @Transactional
    public String signup(Member member){
        String errorMessage = validateDuplicateMember(member);
        if (errorMessage != null) {
            return errorMessage;
        }
        member.setPassword(hashPassword(member.getPassword()));
        memberRepository.save(member);
        return null;
    }

    // 아이디로 회원 조회
    public Member findMember(Long id){
        return memberRepository.findOne(id);
    }

    // 회원 정보 수정
    @Transactional
    public void modifyMember(MyInformationForm form) {
        Member member = memberRepository.findOne(form.getId());
        member.setPassword(hashPassword(form.getPassword()));
        member.setPhoneNumber(form.getPhoneNumber());
        member.setEmail(form.getEmail());
    }

    // 아이디 유효성 검사
    public String validateDuplicateMember(Member member){
        Member findMember = memberRepository.findByUsername(member.getUsername());
        if(findMember != null){
            return "이미 가입된 아이디입니다";
        }
        return null;
    }

    // 비밀번호 확인
    public String passwordCheck(String username, String password){
        Member member = memberRepository.findByUsername(username);
        if(!member.getPassword().equals(password)){
            return "비밀번호가 일치하지 않습니다.";
        }
        return null;
    }

    // 로그인
    public Member login(LoginForm form) {
        Member member = memberRepository.findByUsername(form.getUsername());
        // 입력 비밀번호와 암호화된 비밀번호를 checkPassword()를 통해 비교 검증
        if (member == null || !checkPassword(form.getPassword(), member.getPassword())) {
            // 불일치
            return null;
        } // 일치, 로그인 성공. member 객체 반환
        return member;
    }

    // 비밀번호 암호화
    public String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

    // 비밀번호 검증
    public boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    // 회원탈퇴
    public void withdraw(long id){
        memberRepository.delete(id);
    }

}
