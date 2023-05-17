package com.willneiman.HealthfulPeacieNation.controller;

import com.willneiman.HealthfulPeacieNation.entity.SignupForm;
import com.willneiman.HealthfulPeacieNation.entity.product.Item;
import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import com.willneiman.HealthfulPeacieNation.entity.product.ProductForm;
import com.willneiman.HealthfulPeacieNation.entity.product.Ticket;
import com.willneiman.HealthfulPeacieNation.service.MemberService;
import com.willneiman.HealthfulPeacieNation.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final MemberService memberService;
    private final ProductService productService;

    @GetMapping("/admin/products/new")
    public String newProductView(HttpSession session, Model model){
        ProductForm productForm = new ProductForm();
        model.addAttribute("productForm", productForm);
        return "admin/products/newproduct";
    }

    @PostMapping("/admin/products/new")
    public String saveNewProduct(@Valid @ModelAttribute("productForm") ProductForm form,
                                 BindingResult result, Model model, HttpSession session){
        if(result.hasErrors()){
            System.out.println("form.getName() = " + form.getName());
            System.out.println("form.getCategory() = " + form.getCategory());
            System.out.println("form.getPrice() = " + form.getPrice());
            System.out.println("form.getStock() = " + form.getStock());
            System.out.println("form.getRemainingUses() = " + form.getRemainingUses());
            System.out.println("form.getDescription() = " + form.getDescription());
            System.out.println("form.getThumbnail() = " + form.getThumbnail());
            System.out.println("form.getImage1() = " + form.getImage1());
            System.out.println("form.getImage2() = " + form.getImage2());

//            return "admin/products/newproduct";
        }

        Product product;
        if("item".equals(form.getCategory())) {
            product = new Item();
            ((Item)product).setStock(form.getStock());
        } else if ("ticket".equals(form.getCategory())) {
            product = new Ticket();
            ((Ticket)product).setRemainingUses(form.getRemainingUses());
        } else {
            throw new IllegalArgumentException("유요하지 않은 카테고리: " + form.getCategory());
        }

        product.setName(form.getName());
        product.setPrice(form.getPrice());
        product.setDescription(form.getDescription());
        product.setThumbnail(form.getThumbnail());
        product.setImage1(form.getImage1());
        product.setImage2(form.getImage2());

        productService.newProduct(product);
        return "admin/products/productlist";
    }

}
