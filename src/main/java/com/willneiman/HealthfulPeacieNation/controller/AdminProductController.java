package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.annotation.AdminOnly;
import com.willneiman.HealthfulPeacieNation.model.entity.product.NewProductForm;
import com.willneiman.HealthfulPeacieNation.model.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.model.entity.product.ProductDetailForm;
import com.willneiman.HealthfulPeacieNation.model.entity.product.ProductListForm;
import com.willneiman.HealthfulPeacieNation.model.enums.ItemCategory;
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
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class AdminProductController {

    private final MemberService memberService;
    private final ProductService productService;
    private final RatingService ratingService;
    private final FileService fileService;

    /*
    상품 등록 페이지 뷰
     */

    //
    @GetMapping("/admin/products/new")
    @AdminOnly
    public String newProductView(Model model) {
        NewProductForm newProductForm = new NewProductForm();
        model.addAttribute("productForm", newProductForm);
        return "admin/products/newproduct";
    }

    /*
    상품 등록 프로세스 처리
     */
    @PostMapping("/admin/products/new")
    @AdminOnly
    public String saveNewProduct(@Valid @ModelAttribute("productForm") NewProductForm form,
                                 BindingResult result, Model model, HttpSession session, HttpServletRequest request) {
        if (result.hasErrors()) {
            List<ObjectError> errors = result.getAllErrors();
            for (ObjectError error : errors) {
                System.out.println(error.getDefaultMessage());
            }
            return "admin/products/newproduct";
        }

        // FileService를 사용해 파일을 저장하고, 저장된 파일의 경로를 받아오기
        productService.newProduct(Product.of(form, fileService.processProductFiles(form)));
        return "redirect:/admin/products/product-list";
    }

    @GetMapping("/admin/products/product-list")
    @AdminOnly
    public String adminProductList(HttpSession session, Model model,
                                   @RequestParam(defaultValue = "1") int page,
                                   @RequestParam(defaultValue = "ITEM") ItemCategory category) {
        Pageable pageable = PageRequest.of(page - 1, 10);
        List<Product> productList = productService.findProductsByPageAndCategory(pageable, category.getName().toLowerCase());

        List<ProductListForm> productListForms = productList.stream()
                .map(product -> new ProductListForm(product, category.getName().toLowerCase()))
                .collect(Collectors.toList());

        int totalPages = productService.findTotalPageByCategory(category.getName().toLowerCase(), pageable);
        int startPage = Math.max(page - 5, 1);
        int endPage = Math.min(startPage + 9, totalPages);

        model.addAttribute("productList", productListForms);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentCategory", category.getName());
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        ;
        return "admin/products/productlist";
    }


    @GetMapping("/admin/products/detail/{id}")
    @AdminOnly
    public String adminProductDetail(@PathVariable Long id, Model model,
                                     @RequestParam String category) {
        Product product = productService.findProduct(id);
        //별점 로직 구현
        Map<String, Object> ratingData = ratingService.calculateRating(product);
        ProductDetailForm productDetailForm = new ProductDetailForm(product, category);

        model.addAttribute("product", productDetailForm);
        model.addAttribute("currentCategory", category);
        model.addAllAttributes(ratingData);
        return "admin/products/productdetail";
    }

    @PostMapping("/admin/products/delete")
    @AdminOnly
    public String adminProductDelete(@RequestBody Map<String, Long> body) {
        Long id = body.get("id");
        productService.deleteProduct(id);
        return "redirect:/admin/products/product-list";
    }

    @PostMapping("/admin/products/adjust-stock")
    @AdminOnly
    public String adminAdjustStock(@RequestParam("quantity") int quantity,
                                   @RequestParam("id") Long id) {
        productService.setItemStock(id, quantity);
        return "redirect:/admin/products/detail/" + id + "?category=item";
    }

    @PostMapping("/admin/products/adjust-remaining-uses")
    @AdminOnly
    public String adminAdjustRemainingUses(@RequestParam("quantity") int quantity,
                                           @RequestParam("id") Long id) {
        productService.setTicketRemainingUses(id, quantity);
        return "redirect:/admin/products/detail/" + id + "?category=ticket";
    }

}
