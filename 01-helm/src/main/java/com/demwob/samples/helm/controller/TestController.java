package com.demwob.samples.helm.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Value("${configmap.title}")
    private String title;

    @GetMapping("/test-helm")
    String test() {
        return "Hellow from " + title + " !!";
    }
}

