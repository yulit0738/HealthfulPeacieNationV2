package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.Ticket;
import com.willneiman.HealthfulPeacieNation.repository.ProductRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
@Rollback(value = false)
public class ProductServiceTest {

    @Autowired ProductService productService;
    @Autowired
    ProductRepository productRepository;
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

    @Test
    public void 카테고리_페이징() throws Exception {
        //given
        int pageSize = 10; // 원하는 페이지 크기를 설정하세요
        Pageable pageable = PageRequest.of(0, pageSize); // 첫번째 페이지를 요청

        // 상품들을 생성하고 저장
        for (int i = 0; i < pageSize * 2; i++) {
            Item item = getItem();
            item.setName(item.getName() + i); // 중복되지 않는 이름을 설정
            productService.newProduct(item);
        }
        //when
        List<Item> items = productService.findItemsByPage(pageable);

        //then
        // 반환된 아이템의 크기는 페이지 크기와 같아야 한다.
        assertEquals(pageSize, items.size());
        for (Item item : items) {
            System.out.println("Item: " + item.getName());
        }
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