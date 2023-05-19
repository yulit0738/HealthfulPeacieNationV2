package com.willneiman.HealthfulPeacieNation.repository;

import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.Ticket;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
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

    // Item 카테고리 페이징
    public List<Item> findItemsByPage(Pageable pageable) {
        return em.createQuery("select i from Item i", Item.class)
                .setFirstResult(pageable.getPageNumber() * pageable.getPageSize())
                .setMaxResults(pageable.getPageSize())
                .getResultList();
    }

    // Ticket 카테고리 페이징
    public List<Ticket> findTicketsByPage(Pageable pageable) {
        return em.createQuery("select t from Ticket t", Ticket.class)
                .setFirstResult(pageable.getPageNumber() * pageable.getPageSize())
                .setMaxResults(pageable.getPageSize())
                .getResultList();
    }

    // 총 페이지 수 카운트
    // total page count
    public int findTotalPages(String category, Pageable pageable) {
        Long totalProducts;

        if ("item".equals(category)) {
            totalProducts = em.createQuery("select count(i) from Item i", Long.class).getSingleResult();
        } else if ("ticket".equals(category)) {
            totalProducts = em.createQuery("select count(t) from Ticket t", Long.class).getSingleResult();
        } else {
            throw new IllegalArgumentException("Invalid category: " + category);
        }

        return (int) Math.ceil((double) totalProducts / pageable.getPageSize());
    }
}
