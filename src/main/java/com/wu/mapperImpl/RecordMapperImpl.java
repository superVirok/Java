package com.wu.mapperImpl;/*
 * Created by Virok on 2022/4/30
 */

import com.github.pagehelper.Page;
import com.wu.mapper.RecordMapper;
import com.wu.pojo.Record;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class RecordMapperImpl implements RecordMapper {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public void setSqlSession(SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public Integer addRecord(Record record) {
        return sqlSession.getMapper(RecordMapper.class).addRecord(record);
    }

    @Override
    public Page<Record> searchRecords(Record record) {
        return sqlSession.getMapper(RecordMapper.class).searchRecords(record);
    }
}
