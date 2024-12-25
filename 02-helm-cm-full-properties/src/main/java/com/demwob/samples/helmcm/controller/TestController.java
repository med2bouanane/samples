package com.demwob.samples.helmcm.controller;

import com.demwob.samples.helmcm.dto.UserRequest;
import com.demwob.samples.helmcm.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class TestController {

    private final UserService userService;

    public TestController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/test-helm-cm")
    public String testHelmCm(){
        return "Hello from Demo: Helm Storing Full application properties into the ConfigMap";
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<UserRequest> creteUser(@RequestBody UserRequest userRequest){
        UserRequest userSaved = userService.save(userRequest);
        return new ResponseEntity<>(userSaved, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<UserRequest>> getUsers(){
        return ResponseEntity.ok(userService.getAll());
    }
}
