package com.wu.mapperImpl;/*
 * Created by Virok on 2022/4/27
 */

import com.github.pagehelper.Page;
import com.wu.mapper.BookMapper;
import com.wu.pojo.Book;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigInteger;

public class BookMapperImpl implements BookMapper {
    @Autowired
    private SqlSessionTemplate sqlSession;

    public void setSqlSession(SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public Page<Book> selectNewBooks() {
        return sqlSession.getMapper(BookMapper.class).selectNewBooks();
    }

    @Override
    public Book findById(Integer id) {
        return sqlSession.getMapper(BookMapper.class).findById(id);
    }

    @Override
    public Integer editBook(Book book) {
        return sqlSession.getMapper(BookMapper.class).editBook(book);
    }

    @Override
    public Page<Book> searchBooks(Book book) {
        return  sqlSession.getMapper(BookMapper.class).searchBooks(book);
    }

    @Override
    public Integer addBook(Book book) {
        return sqlSession.getMapper(BookMapper.class).addBook(book);
    }

    @Override
    public Page<Book> selectBorrowed(Book book) {
        return sqlSession.getMapper(BookMapper.class).selectBorrowed(book);
    }

    @Override
    public Page<Book> selectMyBorrowed(Book book) {
        return sqlSession.getMapper(BookMapper.class).selectMyBorrowed(book);
    }

    @Override
    public Integer editBook2(Book book) {
        return sqlSession.getMapper(BookMapper.class).editBook2(book);
    }
}
