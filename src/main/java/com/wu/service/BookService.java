package com.wu.service;/*
 * Created by Virok on 2022/4/27
 */

import com.wu.entity.PageResult;
import com.wu.pojo.Book;
import com.wu.pojo.User;

import java.text.ParseException;

public interface BookService {
    //查询最新上架的图书
    PageResult selectNewBooks(Integer pageNum,Integer pageSize);

    Book findById(Integer id);

    Integer borrowBook(Book book) throws ParseException;

    PageResult search(Book book,Integer pageNum,Integer pageSize);

    Integer addBook(Book book);

    Integer editBook(Book book);

    PageResult searchBorrowed(Book book, User user, Integer pageNum, Integer pageSize);

    boolean returnBook(Integer id,User user);

    Integer returnConfirm(Integer id);

}
