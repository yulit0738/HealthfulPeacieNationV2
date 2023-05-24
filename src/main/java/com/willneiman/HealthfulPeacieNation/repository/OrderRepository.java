package com.willneiman.HealthfulPeacieNation.repository;

import com.willneiman.HealthfulPeacieNation.entity.order.Order;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OrderRepository {

    private final EntityManager em;

    public void save(Order order){
        em.persist(order);
    }

    public List<Order> findAll(){
        return em.createQuery("select o from Order o", Order.class)
                .getResultList();
    }

    public Order findOne(Long id){
        return em.find(Order.class, id);
    }
}
