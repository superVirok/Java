package com.wu.pojo;/*
 * Created by Virok on 2022/4/24
 */

import java.io.Serializable;
import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.stereotype.Component;


@Component
public class Record implements Serializable {
    private Integer recordId; //图书借阅id
    private String recordBookName; //借阅的图书名称
    private String recordBookIsbn; //借阅图书的ISBN
    private String recordBorrower; //图书借阅人姓名
    private Date recordBorrowTime; //图书借阅时间
    private Date recordRemandTime; //图书归还时间

    public Record() {
    }

    public Record(Integer recordId, String recordBookName, String recordBookIsbn, String recordBorrower, Date recordBorrowTime, Date recordRemandTime) {
        this.recordId = recordId;
        this.recordBookName = recordBookName;
        this.recordBookIsbn = recordBookIsbn;
        this.recordBorrower = recordBorrower;
        this.recordBorrowTime = recordBorrowTime;
        this.recordRemandTime = recordRemandTime;
    }

    public Integer getRecordId() {
        return recordId;
    }

    public void setRecordId(Integer recordId) {
        this.recordId = recordId;
    }

    public String getRecordBookName() {
        return recordBookName;
    }

    public void setRecordBookName(String recordBookName) {
        this.recordBookName = recordBookName;
    }

    public String getRecordBookIsbn() {
        return recordBookIsbn;
    }

    public void setRecordBookIsbn(String recordBookIsbn) {
        this.recordBookIsbn = recordBookIsbn;
    }

    public String getRecordBorrower() {
        return recordBorrower;
    }

    public void setRecordBorrower(String recordBorrower) {
        this.recordBorrower = recordBorrower;
    }

    //防止mybatis读取时间字段时自动把时间转换成时间戳
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getRecordBorrowTime() {
        return recordBorrowTime;
    }

    public void setRecordBorrowTime(Date recordBorrowTime) {
        this.recordBorrowTime = recordBorrowTime;
    }

    //防止mybatis读取时间字段时自动把时间转换成时间戳
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getRecordRemandTime() {
        return recordRemandTime;
    }

    public void setRecordRemandTime(Date recordRemandTime) {
        this.recordRemandTime = recordRemandTime;
    }

    @Override
    public String toString() {
        return "Record{" +
                "recordId=" + recordId +
                ", recordBookName='" + recordBookName + '\'' +
                ", recordBookIsbn='" + recordBookIsbn + '\'' +
                ", recordBorrower='" + recordBorrower + '\'' +
                ", recordBorrowTime=" + recordBorrowTime +
                ", recordRemandTime=" + recordRemandTime +
                '}';
    }
}
