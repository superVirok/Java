package com.wu.mapper;/*
 * Created by Virok on 2022/4/25
 */

import com.github.pagehelper.Page;
import com.wu.pojo.User;


public interface UserMapper {

    public boolean register(User user);

    public Integer addUser(User user);

    public User selectByUserName(String userName);

    public User selectByEmail(String email);

    public User select(User user);

    public Page<User> selectEmployee(User user);

    public User findById(Integer id);

    public Integer editUser(User user);
}

