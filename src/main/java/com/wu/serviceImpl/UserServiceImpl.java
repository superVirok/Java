package com.wu.serviceImpl;/*
 * Created by Virok on 2022/4/25
 */


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.wu.entity.PageResult;
import com.wu.mapper.UserMapper;
import com.wu.pojo.User;
import com.wu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;


@Service("UserServiceImpl")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;


    @Override
    public User login(User user) {
        return userMapper.select(user);
    }

    @Override
    public boolean existUserName(User user) {
        User u = userMapper.selectByUserName(user.getUserName());
        return u != null? true:false;
    }

    @Override
    public boolean existEmail(User user) {
        User u = userMapper.selectByEmail(user.getUserEmail());
        return u != null? true:false;
    }

    @Override
    public boolean register(User user) {
        user.setUserRole(2);
        user.setUserStatus(0);
        return userMapper.register(user);
    }

    public Integer addEmployee(User user){

        user.setUserRole(1);
        user.setUserStatus(0);
        if(user.getUserHiredate() == null){
            java.util.Date date = new java.util.Date();
            Date dt = new Date(date.getTime());
            user.setUserHiredate(dt);
        }

        return userMapper.addUser(user);
    }

    @Override
    public PageResult selectEmployee(User user,Integer pageNum,Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        Page<User> page = userMapper.selectEmployee(user);
        return new PageResult(page.getTotal(),page.getResult());
    }

    @Override
    public Integer editUser(User user) {
        return userMapper.editUser(user);
    }

    @Override
    public User findById(Integer id) {
        return userMapper.findById(id);
    }

}
