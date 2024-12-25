package com.demwob.samples.helmcm.service;

import com.demwob.samples.helmcm.dto.UserRequest;

import java.util.List;

public interface UserService {
    UserRequest save(UserRequest userRequest);
    List<UserRequest> getAll();
}
