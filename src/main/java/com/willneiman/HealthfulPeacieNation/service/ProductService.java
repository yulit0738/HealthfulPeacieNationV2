package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.Ticket;
import com.willneiman.HealthfulPeacieNation.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    // 상품 등록
    public void newProduct(Product product){
        productRepository.save(product);
    }

    // 고유 식별자로 찾기
    public Product findProduct(Long id){
        return productRepository.findOne(id);
    }

    // 상품 이름으로 찾기
    public Product findProductByName(String name){
        return productRepository.findByName(name);
    }

    // 모든 상품 리스트 가져오기
    public List<Product> findAllProduct(){
        return productRepository.findAll();
    }

    // Item 카테고리 페이징
    public List<Item> findItemsByPage(Pageable pageable) {
        return productRepository.findItemsByPage(pageable);
    }

    // Ticket 카테고리 페이징
    public List<Ticket> findTicketsByPage(Pageable pageable) {
        return productRepository.findTicketsByPage(pageable);
    }

    // 동적 카테고리 페이징
    public List<Product> findProductsByPageAndCategory(Pageable pageable, String category) {
        if (category.equals("item")) {
            return new ArrayList<Product>(productRepository.findItemsByPage(pageable));
        } else if (category.equals("ticket")) {
            return new ArrayList<Product>(productRepository.findTicketsByPage(pageable));
        } else {
            return new ArrayList<Product>(productRepository.findItemsByPage(pageable));
        }
    }

    // 상품별 최대 페이지 구하기
    public int findTotalPageByCategory(String category, Pageable pageable){
        return productRepository.findTotalPages(category, pageable);
    }

    // 특정 상품 삭제
    public void deleteProduct(Long id){
        productRepository.delete(id);
    }

    // 주문 시 재고 감소(환불 시 재고 복구)
    public void adjustStock(Long itemId, int adjustment) {
        productRepository.adjustStock(itemId, adjustment);
    }

    // item 재고 수정
    public void setItemStock(Long id, int quantity) {
        productRepository.setStock(id, quantity);
    }
    // ticket 기본 사용횟수 수정
    public void setTicketRemainingUses(Long id, int quantity) {
        productRepository.setRemainingUses(id, quantity);
    }
}
