package com.demwob.samples.helmcm.service;

import com.demwob.samples.helmcm.dto.UserRequest;
import com.demwob.samples.helmcm.mapper.UserMapper;
import com.demwob.samples.helmcm.models.User;
import com.demwob.samples.helmcm.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;

    public UserServiceImpl(UserRepository userRepository, UserMapper userMapper) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
    }

    @Override
    public UserRequest save(UserRequest userRequest) {
        User user = userMapper.toUser(userRequest);
        User userSaved = userRepository.save(user);
        return userMapper.toUserRequest(userSaved);
    }

    @Override
    public List<UserRequest> getAll() {
        List<User> users = userRepository.findAll();
        return userMapper.toUserRequestList(users);
    }
}
