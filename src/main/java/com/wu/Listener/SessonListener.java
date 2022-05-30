package com.wu.Listener;/*
 * Created by Virok on 2022/4/29
 */

import com.wu.Context.MySessionContext;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;



public class SessonListener implements HttpSessionListener {
    private MySessionContext msc = MySessionContext.getInstance();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        msc.addSession(session);
    }

}
