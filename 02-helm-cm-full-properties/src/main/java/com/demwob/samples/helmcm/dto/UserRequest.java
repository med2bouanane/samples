package com.demwob.samples.helmcm.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class UserRequest {
    private Long id;
    private String firstName;
    private String lastName;
    private int age;
}
