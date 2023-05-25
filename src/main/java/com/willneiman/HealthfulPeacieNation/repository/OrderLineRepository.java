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

    @Transactional
    public void save(OrderLine orderLine){
        em.persist(orderLine);
    }

    public List<OrderLine> findAll(){
        return em.createQuery("select ol from OrderLine ol", OrderLine.class)
                .getResultList();
    }

    public OrderLine findOne(Long id){
        return em.find(OrderLine.class, id);
    }
}
