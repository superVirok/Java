package com.wu.controller;/*
 * Created by Virok on 2022/4/27
 */

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wu.Context.MySessionContext;
import com.wu.entity.PageResult;
import com.wu.entity.Result;
import com.wu.pojo.Book;
import com.wu.pojo.User;
import com.wu.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;

@Controller
@RequestMapping("/book")
public class BookContoller {

    @Autowired
    private BookService bookService;


    @RequestMapping(value="/selectNewBooks",produces="application/json;charset=UTF-8")
    public void selectNewBooks(HttpServletResponse response) throws IOException {
        int pageNum = 1;
        int pageSize = 10;

        PageResult pageResult = bookService.selectNewBooks(pageNum,pageSize);
        ObjectMapper om = new ObjectMapper();
        String pr = om.writeValueAsString(pageResult);

        response.setContentType("application/json");
        response.getWriter().print(pr);
    }

    @ResponseBody
    @GetMapping("/findById")
    public Result<Book> findById(String bookId){

        try{
            Book book = bookService.findById(Integer.parseInt(bookId));
            if(book == null)
                return new Result(false,"查询图书失败!");
            return  new Result(true,"查询图书成功",book);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,"查询图书失败!");
        }
    }


    @ResponseBody
    @GetMapping("/borrowBook")
    public Result borrowBook(String bookId, String bookReturnTime) throws ParseException {
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = simpleDateFormat.parse(bookReturnTime);

        Date dt = new Date(date.getTime());

        MySessionContext msc = MySessionContext.getInstance();   //应对二次跨域,自定义session上下文

        HttpSession session = msc.getSession();

        User user = (User)session.getAttribute("USER_SESSION");
        Book book = bookService.findById(Integer.parseInt(bookId));

        String name = user.getUserName();

        book.setBookReturnTime(dt);
        book.setBookBorrower(name);


        try{
            Integer count = bookService.borrowBook(book);

            if(count != 1)
                return new Result(false,"借阅图书失败");
            else
                return new Result(true,"借阅成功,请到附近书点领取书籍!");

        } catch (ParseException e) {
            e.printStackTrace();
            return new Result(false,"借阅图书失败");
        }
    }


    @GetMapping(value="/search",produces="application/json;charset=UTF-8")
    public void search(Book book,Integer pageNum,Integer pageSize,HttpServletResponse response) throws IOException {
         if(pageNum == null ) pageNum = 1;
         if(pageSize == null) pageSize = 10;


         PageResult pageResult = bookService.search(book,pageNum,pageSize);

         ObjectMapper om = new ObjectMapper();
         String pr = om.writeValueAsString(pageResult);
         response.setContentType("application/json");
         response.getWriter().print(pr);
    }

    @ResponseBody
    @GetMapping("/addBook")
    public Result addBook(Book book){
        Integer count = bookService.addBook(book);
        try{
            if(count != 1)
                return new Result(false, "新增图书失败!");
            return new Result(true, "新增图书成功!");
        }catch(Exception e){
            e.printStackTrace();
            return new Result(false,"新增图书失败!");
        }

    }


    @ResponseBody
    @GetMapping("/editBook")
    public Result editBook(Book book){
        try{
            Integer count = bookService.editBook(book);
            if (count != 1)
                return new Result(false,"编辑失败!");
            return new Result(true,"编辑成功!");
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,"编辑失败!");
        }
    }


    @GetMapping("/searchBorrowed")
    public void searchBorrowed(Book book,Integer pageNum,Integer pageSize,HttpServletResponse response) throws IOException {
        if (pageNum == null) pageNum =1;
        if (pageSize == null) pageSize = 10;

        MySessionContext msc = MySessionContext.getInstance();
        HttpSession session = msc.getSession();
        User user = (User)session.getAttribute("USER_SESSION");

        PageResult pageResult = bookService.searchBorrowed(book,user,pageNum,pageSize);


        ObjectMapper om = new ObjectMapper();
        String pr = om.writeValueAsString(pageResult);
        response.setContentType("application/json");
        response.getWriter().print(pr);
    }

    @ResponseBody
    @GetMapping("/returnBook")
    public Result returnBook(String bookId){
        MySessionContext msc = MySessionContext.getInstance();
        HttpSession session = msc.getSession();
        User user = (User)session.getAttribute("USER_SESSION");
        try{
            boolean flag = bookService.returnBook(Integer.parseInt(bookId),user);
            if(!flag)
                return new Result(false,"还书失败!");
            return new Result(true,"还书确认中,请到附近还书地点还书!");
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,"还书失败!");
        }
    }

    @ResponseBody
    @GetMapping("/returnConfirm")
    public  Result returnConfirm(String bookId){
        try{
            Integer count = bookService.returnConfirm(Integer.parseInt(bookId));
            if(count != 1)
                return new Result(false,"确认失败!");
            return new Result(true,"确认成功!");
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,"确认失败!");
        }
    }
}
