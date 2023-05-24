package com.willneiman.HealthfulPeacieNation.repository;

import com.willneiman.HealthfulPeacieNation.entity.order.Order;
import com.willneiman.HealthfulPeacieNation.entity.order.OrderLine;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OrderLineRepository {

    private final EntityManager em;

    // 주문 상품 저장
    public void save(OrderLine orderLine){
        em.persist(orderLine);
    }

    // 주문 상품 전체 출력(필요 없음)
    public List<OrderLine> findAll(){
        return em.createQuery("select ol from OrderLine ol", OrderLine.class)
                .getResultList();
    }

    // 주문 상품 조회
    public OrderLine findOne(Long id){
        return em.find(OrderLine.class, id);
    }
}
