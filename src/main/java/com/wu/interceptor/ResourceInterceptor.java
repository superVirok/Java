package com.wu.interceptor;/*
 * Created by Virok on 2022/4/24
 */

import com.wu.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResourceInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User)request.getSession().getAttribute("USER_SESSION");
        String uri = request.getRequestURI();

        
        if (user != null)
            return true;


        if (uri.indexOf("login") > 0)
            return true;

        request.setAttribute("msg","您还没有登录,请先登录!");
        request.getRequestDispatcher("/login.ftl").forward(request,response);
        return false;
    }
}
