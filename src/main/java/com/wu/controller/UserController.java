package com.wu.controller;/*
 * Created by Virok on 2022/4/25
 */

import com.wu.Context.MySessionContext;
import com.wu.entity.PageResult;
import com.wu.entity.Result;
import com.wu.pojo.User;
import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.wu.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;


//@CrossOrigin(origins = "http://localhost",allowCredentials="true")
@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @ResponseBody
    @GetMapping("/login/checkUserEmail")
    public boolean checkEmail(User user,HttpServletResponse response) throws IOException {
     boolean success = userService.existEmail(user);
      return success;
    }

    @ResponseBody
    @GetMapping("/login/checkUserName")
    public boolean checkUserName(User user,HttpServletResponse response) throws IOException {
        boolean success = userService.existUserName(user);
        return  success;
    }


    @GetMapping("/main")
    public String main(Model model,HttpServletRequest request){

        User user = (User)request.getSession().getAttribute("USER_SESSION");
        model.addAttribute("user",user);
        return "main";
    }

    @PostMapping("/login")
    public String userLogin(User user, Model model, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User u = userService.login(user);

        if (u == null){
            model.addAttribute("errLogMsg","账号或密码错误");
            return "forward:/login.ftl";
        }
        else {
            HttpSession session = request.getSession();
            session.setAttribute("USER_SESSION",u);

            MySessionContext msc = MySessionContext.getInstance();
            msc.getSession().setAttribute("USER_SESSION",u);

            model.addAttribute("user",u);
            return "main";
        }

    }

    @ResponseBody
    @GetMapping ("/login/userRegister")
    public boolean userRegister(User user,HttpServletResponse response) throws IOException {
        System.out.println(user);
        boolean success = userService.register(user);
        return success;
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request){
        MySessionContext msc = MySessionContext.getInstance();
        HttpSession session = msc.getSession();
        session.removeAttribute("USER_SESSION");
        request.getSession().removeAttribute("USER_SESSION");
        return "forward:/login.ftl";
    }

    @ResponseBody
    @GetMapping("/searchEmployee")
    public PageResult searchEmployee(User user,Integer pageNum,Integer pageSize){

        if(pageNum == null) pageNum = 1;
        if (pageSize == null) pageSize = 10;

        PageResult pageResult = userService.selectEmployee(user,pageNum,pageSize);

        return pageResult;
    }


    @ResponseBody
    @GetMapping("/editEmployee")
    public Result editUser(User user,String userHiretime,String userDeparturetime) throws ParseException {
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date hiretime = simpleDateFormat.parse(userHiretime);
        java.util.Date departuretime = simpleDateFormat.parse(userDeparturetime);

        Date dt_hiretime = new Date(hiretime.getTime());
        Date dt_departuretime = new Date(departuretime.getTime());
        user.setUserHiredate(dt_hiretime);
        user.setUserDeparturedate(dt_departuretime);
        try{
            Integer count = userService.editUser(user);
            if (count != 1)
                return new Result(false,"信息修改失败!");
            return new Result(true,"信息修改成功!");
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,"信息修改失败!");
        }
    }


    @ResponseBody
    @GetMapping("/addEmployee")
    public Result addEmployee(User user){
        try{
             Integer count  = userService.addEmployee(user);
             if (count != 1)
                 return new Result(false,"员工信息添加失败!");
             return new Result(true,"员工信息添加成功!");
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,"员工信息添加失败!");
        }
    }

    @ResponseBody
    @GetMapping("/findEmpById")
    public Result findEmpById(Integer userId){
        try{
            User user = userService.findById(userId);
            if (user == null)
                return new Result(false,"查询失败!");
            return new Result(true,"查询员工信息成功!",user);
        }catch (Exception e){
            e.printStackTrace();
            return new Result(false,"查询失败!");
        }
    }
}
