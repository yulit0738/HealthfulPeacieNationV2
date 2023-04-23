package com.willneiman.HealthfulPeacieNation.repository;

import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import java.util.List;

@Repository
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProductRepository {

    private final EntityManager em;

    @Transactional
    public Long save(Product product) {
        em.persist(product);
        return product.getId();
    }

    public Product findOne(Long id) {
        return em.find(Product.class, id);
    }

    public List<Product> findAll() {
        return em.createQuery("select p from Product p", Product.class)
                .getResultList();
    }

    public Product findByName(String name) {
        try {
            return em.createQuery("select p from Product p where p.name = :name", Product.class)
                    .setParameter("name", name)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Transactional
    public void delete(Long id) {
        if (em.find(Product.class, id) != null) {
            em.remove(id);
        }

    }

}
