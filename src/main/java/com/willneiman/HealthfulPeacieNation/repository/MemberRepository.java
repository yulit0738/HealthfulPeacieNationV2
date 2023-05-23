package com.willneiman.HealthfulPeacieNation.repository;

import com.willneiman.HealthfulPeacieNation.entity.member.Member;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class MemberRepository {

    private final EntityManager em;

    // 회원가입
    public Long save(Member member){
        em.persist(member);
        return member.getId();
    }

    // 고유 키로 조회
    public Member findOne(Long id){
        return em.find(Member.class, id);
    }

    public List<Member> findAll(){
        return em.createQuery("select m from Member m", Member.class)
                .getResultList();
    }

    public void delete(Long id){
        Member member = em.find(Member.class, id);
        if(em.find(Member.class, id) != null){
            em.remove(member);
        }
    }

    public Member findByUsername(String username) {
        try {
            return em.createQuery("select m from Member m where m.username = :username", Member.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

}
