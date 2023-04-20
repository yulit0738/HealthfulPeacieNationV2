package com.willneiman.HealthfulPeacieNation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/test")
    public String testPage(Model model){
        String modelTest = "test model";
        model.addAttribute("model", modelTest);
        return "testpage";
    }

    @GetMapping("/hello")
    public String hello(Model model){
        //data라는 이름을 가진 hello!!라는 데이터를 모델에 담는다.
//        model.addAttribute("data", "hello!!");
        // 화면 이름
        return "hello";
    }

}
