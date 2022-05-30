package com.wu.service;/*
 * Created by Virok on 2022/4/25
 */

import com.github.pagehelper.Page;
import com.wu.entity.PageResult;
import com.wu.pojo.User;
import org.springframework.stereotype.Service;


public interface UserService {

    public User login(User user);

    public boolean existUserName(User user);

    public boolean existEmail(User user);

    public boolean register(User user);

    public Integer addEmployee(User user);

    public PageResult selectEmployee(User user,Integer pageNum,Integer pageSize);

    public Integer editUser(User user);

    public User findById(Integer id);
}
