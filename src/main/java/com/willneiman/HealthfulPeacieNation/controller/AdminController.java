package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.annotation.AdminOnly;
import com.willneiman.HealthfulPeacieNation.entity.Member;
import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.ProductForm;
import com.willneiman.HealthfulPeacieNation.entity.product.Ticket;
import com.willneiman.HealthfulPeacieNation.service.FileService;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import com.willneiman.HealthfulPeacieNation.service.ProductService;
import com.willneiman.HealthfulPeacieNation.service.RatingService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final MemberService memberService;
    private final ProductService productService;
    private final RatingService ratingService;
    private final FileService fileService;

    /*
    상품 등록 페이지 뷰
     */

    @GetMapping("/admin/products/new")
    @AdminOnly
    public String newProductView(Model model) {
        ProductForm productForm = new ProductForm();
        model.addAttribute("productForm", productForm);
        return "admin/products/newproduct";
    }

    /*
    상품 등록 프로세스 처리
     */
    @PostMapping("/admin/products/new")
    @AdminOnly
    public String saveNewProduct(@Valid @ModelAttribute("productForm") ProductForm form,
                                 BindingResult result, Model model, HttpSession session, HttpServletRequest request) {
        if (result.hasErrors()) {
            List<ObjectError> errors = result.getAllErrors();
            for (ObjectError error : errors) {
                System.out.println(error.getDefaultMessage());
            }
            return "admin/products/newproduct";
        }

        Product product;
        if ("item".equals(form.getCategory())) {
            product = new Item();
            ((Item) product).setStock(form.getStock());
        } else if ("ticket".equals(form.getCategory())) {
            product = new Ticket();
            ((Ticket) product).setRemainingUses(form.getRemainingUses());
        } else {
            throw new IllegalArgumentException("유효하지 않은 카테고리: " + form.getCategory());
        }

        product.setName(form.getName());
        product.setPrice(form.getPrice());
        product.setDescription(form.getDescription());

        // FileService를 사용해 파일을 저장하고, 저장된 파일의 경로를 받아오기
        Map<String, String> productFiles = fileService.processProductFiles(form);

        // 저장된 파일의 경로를 Product에 설정하기
        product.setThumbnail(productFiles.get("thumbnail"));
        product.setImage1(productFiles.get("image1"));
        product.setImage2(productFiles.get("image2"));

        productService.newProduct(product);
        return "redirect:/admin/products/product-list";
    }

    @GetMapping("/admin/products/product-list")
    @AdminOnly
    public String productList(HttpSession session, Model model,
                              @RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "item") String category) {
        Pageable pageable = PageRequest.of(page, 20);
        List<Product> productList = productService.findProductsByPageAndCategory(pageable, category);
        model.addAttribute("productList", productList);
        model.addAttribute("currentPage", page); // current page number
        return "admin/products/productlist";
    }

    @GetMapping("/admin/products/detail/{id}")
    @AdminOnly
    public String showProduct(@PathVariable Long id, Model model) {
        Product product = productService.findProduct(id);
        //별점 로직 구현
        Map<String, Object> ratingData = ratingService.calculateRating(product);

        model.addAttribute("product", product);
        model.addAllAttributes(ratingData);
        return "admin/products/productdetail";
    }

}
