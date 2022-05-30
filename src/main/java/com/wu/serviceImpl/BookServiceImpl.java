package com.wu.serviceImpl;/*
 * Created by Virok on 2022/4/27
 */

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.wu.entity.PageResult;
import com.wu.mapper.BookMapper;
import com.wu.mapper.RecordMapper;
import com.wu.pojo.Book;
import com.wu.pojo.User;
import com.wu.pojo.Record;
import com.wu.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;

@Service("BookServiceImpl")
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private RecordMapper recordMapper;
    @Override
    public PageResult selectNewBooks(Integer pageNum, Integer pageSize) {

        PageHelper.startPage(pageNum,pageSize);
        Page<Book> page=bookMapper.selectNewBooks();
        return new PageResult(page.getTotal(),page.getResult());
    }

    @Override
    public Book findById(Integer id) {
       return bookMapper.findById(id);
    }

    @Override
    public Integer borrowBook(Book book){
        Book b = findById(book.getBookId());

        java.util.Date date = new java.util.Date();

        Date dt = new Date(date.getTime());

        book.setBookBorrowTime(dt);
        book.setBookStatus(1);
        book.setBookPrice(b.getBookPrice());
        book.setBookUploadTime(b.getBookUploadTime());

        return bookMapper.editBook(book);
    }

    @Override
    public PageResult search(Book book, Integer pageNum, Integer pageSize) {

        PageHelper.startPage(pageNum,pageSize);
        Page<Book> page = bookMapper.searchBooks(book);
        return new PageResult(page.getTotal(),page.getResult());
    }

    @Override
    public Integer addBook(Book book) {
        java.util.Date date =new java.util.Date();
        Date dt = new Date(date.getTime());
        book.setBookUploadTime(dt);
        return bookMapper.addBook(book);
    }

    @Override
    public Integer editBook(Book book) {
        return  bookMapper.editBook(book);
    }

    @Override
    public PageResult searchBorrowed(Book book, User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        Page<Book> page;
        book.setBookBorrower(user.getUserName());
        if (user.getUserRole() == 0)
            page = bookMapper.selectBorrowed(book);
        else
            page = bookMapper.selectMyBorrowed(book);
        return new PageResult(page.getTotal(),page.getResult());
    }

    @Override
    public boolean returnBook(Integer id, User user) {
        Book book = findById(id);
        boolean flag = book.getBookBorrower().equals(user.getUserName());
        if (flag){
            book.setBookStatus(2);
            bookMapper.editBook(book);
        }
        return flag;
    }

    @Override
    public Integer returnConfirm(Integer id) {
        Book book = findById(id);
        Record record = this.setRecord(book);
        book.setBookStatus(0);
        book.setBookBorrower("");
        book.setBookBorrowTime(null);
        book.setBookReturnTime(null);

        Integer count = bookMapper.editBook2(book);
        if (count == 1)
            return  recordMapper.addRecord(record);
        return 0;
    }

    private Record setRecord(Book book) {
        Record record = new Record();
        record.setRecordBookName(book.getBookName());
        record.setRecordBookIsbn(book.getBookIsbn());
        record.setRecordBorrower(book.getBookBorrower());
        record.setRecordBorrowTime(book.getBookBorrowTime());

        java.util.Date date = new java.util.Date();
        Date dt = new Date(date.getTime());
        record.setRecordRemandTime(dt);
        return record;
    }


}
