package com.demwob.samples.helmcm.mapper;

import com.demwob.samples.helmcm.dto.UserRequest;
import com.demwob.samples.helmcm.models.User;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface UserMapper {

    UserRequest toUserRequest(User user);

    User toUser(UserRequest userRequest);

    List<UserRequest> toUserRequestList(List<User> userList);

    List<User> toUserList(List<UserRequest> userRequestList);
}
