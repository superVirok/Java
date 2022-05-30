package com.wu.pojo;/*
 * Created by Virok on 2022/4/24
 */


import java.sql.Date;
import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.stereotype.Component;


@Component("Book")
public class Book implements Serializable {
    private Integer bookId;  //图书编号
    private String bookName; //图书名称
    private String bookIsbn; //图书标准ISBN
    private String bookPress; //图书出版社
    private String bookAuthor; //图书作者
    private Integer bookPagination; //图书页数
    private Double bookPrice; //图书价格
    private Date bookUploadTime; //图书上架时间
    private Integer bookStatus; //图书状态,0代表可借阅,1代表已借阅,2代表已下架
    private String bookBorrower; //图书借阅人
    private Date bookBorrowTime; //图书借阅时间
    private Date bookReturnTime; //图书预计归还时间

    public Book() {
    }

    public Book(Integer bookId, String bookName, String bookIsbn, String bookPress, String bookAuthor, Integer bookPagination, Double bookPrice, Date bookUploadTime, Integer bookStatus, String bookBorrower, Date bookBorrowTime, Date bookReturnTime) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.bookIsbn = bookIsbn;
        this.bookPress = bookPress;
        this.bookAuthor = bookAuthor;
        this.bookPagination = bookPagination;
        this.bookPrice = bookPrice;
        this.bookUploadTime = bookUploadTime;
        this.bookStatus = bookStatus;
        this.bookBorrower = bookBorrower;
        this.bookBorrowTime = bookBorrowTime;
        this.bookReturnTime = bookReturnTime;
    }

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getBookIsbn() {
        return bookIsbn;
    }

    public void setBookIsbn(String bookIsbn) {
        this.bookIsbn = bookIsbn;
    }

    public String getBookPress() {
        return bookPress;
    }

    public void setBookPress(String bookPress) {
        this.bookPress = bookPress;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public Integer getBookPagination() {
        return bookPagination;
    }

    public void setBookPagination(Integer bookPagination) {
        this.bookPagination = bookPagination;
    }

    public Double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(Double bookPrice) {
        this.bookPrice = bookPrice;
    }

    //防止mybatis读取时间字段时自动把时间转换成时间戳
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBookUploadTime() {
        return bookUploadTime;
    }


    public void setBookUploadTime(Date bookUploadTime) {
        this.bookUploadTime = bookUploadTime;
    }

    public Integer getBookStatus() {
        return bookStatus;
    }

    public void setBookStatus(Integer bookStatus) {
        this.bookStatus = bookStatus;
    }

    public String getBookBorrower() {
        return bookBorrower;
    }

    public void setBookBorrower(String bookBorrower) {
        this.bookBorrower = bookBorrower;
    }

    //防止mybatis读取时间字段时自动把时间转换成时间戳
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBookBorrowTime() {
        return bookBorrowTime;
    }



    public void setBookBorrowTime(Date bookBorrowTime) {
        this.bookBorrowTime = bookBorrowTime;
    }

    //防止mybatis读取时间字段时自动把时间转换成时间戳
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBookReturnTime() {
        return bookReturnTime;
    }

    public void setBookReturnTime(Date bookReturnTime) {
        this.bookReturnTime = bookReturnTime;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bookId=" + bookId +
                ", bookName='" + bookName + '\'' +
                ", bookIsbn='" + bookIsbn + '\'' +
                ", bookPress='" + bookPress + '\'' +
                ", bookAuthor='" + bookAuthor + '\'' +
                ", bookPagination=" + bookPagination +
                ", bookPrice=" + bookPrice +
                ", bookUploadTime=" + bookUploadTime +
                ", bookStatus=" + bookStatus +
                ", bookBorrower='" + bookBorrower + '\'' +
                ", bookBorrowTime=" + bookBorrowTime +
                ", bookReturnTime=" + bookReturnTime +
                '}';
    }
}
