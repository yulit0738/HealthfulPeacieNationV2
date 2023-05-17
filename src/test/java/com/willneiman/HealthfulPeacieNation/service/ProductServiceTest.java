package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.Ticket;
import com.willneiman.HealthfulPeacieNation.repository.ProductRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
@Rollback(false)
public class ProductServiceTest {

    @Autowired ProductService productService;
    @Autowired ProductRepository productRepository;
    @Autowired EntityManager em;

    @Test
    public void 상품_생성() throws Exception {
        //given
        Item item = getItem();
        Ticket ticket = getTicket();

        //when
        productService.newProduct(item);
        productService.newProduct(ticket);

        Product findItem = em.find(Product.class, item.getId());
        Product findTicket = em.find(Product.class, ticket.getId());

        //then
        System.out.println("findItem = " + findItem.toString());
        System.out.println("findTicket = " + findTicket.toString());
        assertEquals(item.getId(), findItem.getId());
        assertEquals(ticket.getId(), findTicket.getId());
    }

    @Test
    public void 상품_조회() throws Exception {
        //given
        Item item = getItem();
        productService.newProduct(item);
        Long newItem = item.getId();
        em.flush();
        em.clear();
        //when
        Product findProduct = productService.findProduct(newItem);
        System.out.println("findProduct = " + findProduct);
        //then
        assertEquals(item.getId(), findProduct.getId());
    }

    private static Item getItem() {
        Item item = new Item();
        item.setName("테스트상품1");
        item.setPrice(10000);
        return item;
    }
    private static Ticket getTicket() {
        Ticket ticket = new Ticket();
        ticket.setName("테스트티켓1");
        ticket.setPrice(20000);
        return ticket;
    }

}