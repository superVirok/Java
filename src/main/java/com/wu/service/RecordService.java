package com.wu.service;/*
 * Created by Virok on 2022/4/30
 */

import com.wu.entity.PageResult;
import com.wu.pojo.Record;
import com.wu.pojo.User;

public interface RecordService {
    Integer addRecord(Record record);

    PageResult searchRecords(Record record, User user, Integer pageNum, Integer pageSize);
}
