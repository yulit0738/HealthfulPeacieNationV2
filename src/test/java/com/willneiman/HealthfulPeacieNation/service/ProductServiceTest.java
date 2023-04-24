package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.repository.ProductRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class ProductServiceTest {

    @Autowired ProductService productService;
    @Autowired ProductRepository productRepository;
    @Autowired EntityManager em;

    @Test
    public void 상품_생성() throws Exception {
        //given
        Item item = getItem();
        //when
        productService.newProduct(item);
        Product findProduct = em.find(Product.class, item.getId());
        //then
        System.out.println("findProduct = " + findProduct.toString());
        System.out.println("product = " + item.toString());
        assertEquals(item.getId(), findProduct.getId());
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

}