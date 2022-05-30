package com.wu.mapperImpl;/*
 * Created by Virok on 2022/4/25
 */

import com.github.pagehelper.Page;
import com.wu.mapper.UserMapper;
import com.wu.pojo.User;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class UserMapperImpl implements UserMapper {
    @Autowired
    private SqlSessionTemplate sqlSession;

    public void setSqlSession(SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public boolean register(User user) {
        return sqlSession.getMapper(UserMapper.class).register(user);
    }


    public Integer addUser(User user){
        return  sqlSession.getMapper(UserMapper.class).addUser(user);
    }
    @Override
    public User selectByUserName(String userName) {
        User user = sqlSession.getMapper(UserMapper.class).selectByUserName(userName);
        return user;
    }

    @Override
    public User selectByEmail(String email) {
        User user = sqlSession.getMapper(UserMapper.class).selectByEmail(email);
        return user;
    }

    @Override
    public User select(User user) {
        return sqlSession.getMapper(UserMapper.class).select(user);
    }

    @Override
    public Page<User> selectEmployee(User user) {
        return sqlSession.getMapper(UserMapper.class).selectEmployee(user);
    }

    @Override
    public User findById(Integer id) {
        return sqlSession.getMapper(UserMapper.class).findById(id);
    }

    @Override
    public Integer editUser(User user) {
        return sqlSession.getMapper(UserMapper.class).editUser(user);
    }
}
