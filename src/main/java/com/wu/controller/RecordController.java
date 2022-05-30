package com.wu.controller;/*
 * Created by Virok on 2022/4/30
 */

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wu.Context.MySessionContext;
import com.wu.entity.PageResult;
import com.wu.pojo.Record;
import com.wu.pojo.User;
import com.wu.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/record")
public class RecordController {

    @Autowired
    private RecordService recordService;

    @GetMapping("/searchRecords")
    private void searchRecords(Record record, Integer pageNum, Integer pageSize,
                               HttpServletResponse response) throws IOException {
        if (pageNum == null) pageNum = 1;
        if (pageSize == null) pageSize = 10;


        MySessionContext msc = MySessionContext.getInstance();
        HttpSession session = msc.getSession();

        User user = (User)session.getAttribute("USER_SESSION");
        PageResult pageResult = recordService.searchRecords(record,user,pageNum,pageSize);
        ObjectMapper om = new ObjectMapper();
        String pr = om.writeValueAsString(pageResult);
        response.getWriter().print(pr);
    }
}
