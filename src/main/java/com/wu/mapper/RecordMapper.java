package com.wu.mapper;/*
 * Created by Virok on 2022/4/30
 */

import com.github.pagehelper.Page;
import com.wu.pojo.Record;

public interface RecordMapper {
    Integer addRecord(Record record);

    Page<Record> searchRecords(Record record);
}
