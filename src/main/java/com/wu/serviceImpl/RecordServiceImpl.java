package com.wu.serviceImpl;/*
 * Created by Virok on 2022/4/30
 */

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.wu.entity.PageResult;
import com.wu.mapper.RecordMapper;
import com.wu.pojo.Record;
import com.wu.pojo.User;
import com.wu.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("RecordServiceImpl")
public class RecordServiceImpl implements RecordService {
    @Autowired
    private RecordMapper recordMapper;

    @Override
    public Integer addRecord(Record record) {
        return recordMapper.addRecord(record);
    }

    @Override
    public PageResult searchRecords(Record record, User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        if (user.getUserRole() != 0)
            record.setRecordBorrower(user.getUserName());
        Page<Record> page = recordMapper.searchRecords(record);
        return new PageResult(page.getTotal(),page.getResult());

    }
}
