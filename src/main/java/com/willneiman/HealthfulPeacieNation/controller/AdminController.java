package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.ProductForm;
import com.willneiman.HealthfulPeacieNation.entity.product.Ticket;
import com.willneiman.HealthfulPeacieNation.service.FileService;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import com.willneiman.HealthfulPeacieNation.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final MemberService memberService;
    private final ProductService productService;

    private final FileService fileService;

    /*
    상품 등록 페이지 뷰
     */
    @GetMapping("/admin/products/new")
    public String newProductView(HttpSession session, Model model){
        ProductForm productForm = new ProductForm();
        model.addAttribute("productForm", productForm);
        return "admin/products/newproduct";
    }
    /*
    상품 등록 프로세스 처리
     */
    @PostMapping("/admin/products/new")
    public String saveNewProduct(@Valid @ModelAttribute("productForm") ProductForm form,
                                 BindingResult result, Model model, HttpSession session){
        if(result.hasErrors()){
            System.out.println("hasErrors()");
            List<ObjectError> errors = result.getAllErrors();
            for (ObjectError error : errors) {
                System.out.println(error.getDefaultMessage());
            }
            return "admin/products/newproduct";
        }

        Product product;
        if("item".equals(form.getCategory())) {
            product = new Item();
            ((Item)product).setStock(form.getStock());
        } else if ("ticket".equals(form.getCategory())) {
            product = new Ticket();
            ((Ticket)product).setRemainingUses(form.getRemainingUses());
        } else {
            throw new IllegalArgumentException("유효하지 않은 카테고리: " + form.getCategory());
        }

        product.setName(form.getName());
        product.setPrice(form.getPrice());
        product.setDescription(form.getDescription());

        // FileService를 사용해 파일을 저장하고, 저장된 파일의 경로를 받아오기
        String thumbnailPath = fileService.storeFile(form.getThumbnail());
        String imagePath1 = fileService.storeFile(form.getImage1());
        String imagePath2 = fileService.storeFile(form.getImage2());

        // 저장된 파일의 경로를 Product에 설정하기
        product.setThumbnail(thumbnailPath);
        product.setImage1(imagePath1);
        product.setImage2(imagePath2);

        productService.newProduct(product);
        return "redirect:/admin/products/product-list";
    }

    @GetMapping("admin/products/product-list")
    public String productList(HttpSession session, Model model){
        List<Product> productList = productService.findAllProduct();
        model.addAttribute("productList", productList);
        return "admin/products/productlist";
    }

}
