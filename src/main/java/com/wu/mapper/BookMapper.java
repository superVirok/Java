package com.wu.mapper;/*
 * Created by Virok on 2022/4/27
 */

import com.github.pagehelper.Page;
import com.wu.pojo.Book;

public interface BookMapper {
    Page<Book> selectNewBooks();

    public Book findById(Integer id);

    public Integer editBook(Book book);

    public Page<Book> searchBooks(Book book);

    public Integer addBook(Book book);

    public Page<Book> selectBorrowed(Book book);

    public Page<Book> selectMyBorrowed(Book book);

    public Integer editBook2(Book book);
}
