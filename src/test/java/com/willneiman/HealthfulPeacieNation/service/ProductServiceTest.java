package com.willneiman.HealthfulPeacieNation.service;

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
        Product product = getProduct();
        //when
        productService.newProduct(product);
        Product findProduct = em.find(Product.class, product.getId());
        //then
        System.out.println("findProduct = " + findProduct.toString());
        System.out.println("product = " + product.toString());
        assertEquals(product.getId(), findProduct.getId());
    }

    private static Product getProduct() {
        Product product = new Product();
        product.setName("테스트상품1");
        product.setPrice(10000);
        return product;
    }

}