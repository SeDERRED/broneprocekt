package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Pagecontroller {
    @GetMapping("/")
    public String home() {
        return "index"; // Spring ищет src/main/resources/templates/index.html
    }
}