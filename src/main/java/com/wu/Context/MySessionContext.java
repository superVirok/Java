package com.wu.Context;/*
 * Created by Virok on 2022/4/29
 */

import javax.servlet.http.HttpSession;
import java.util.HashMap;

public class MySessionContext {
     private static MySessionContext instance;
     private HashMap<String, HttpSession> sessionHashMap;

     private MySessionContext(){
         sessionHashMap = new HashMap<String,HttpSession>();
     }

     public static MySessionContext  getInstance(){
         if (instance == null)
             instance = new MySessionContext();
         return  instance;
     }

     public synchronized void addSession(HttpSession session){
         if(!sessionHashMap.containsKey("JSESSION1"))
             sessionHashMap.put("JSESSION1",session);
     }

     public synchronized HttpSession getSession(){
         return sessionHashMap.get("JSESSION1");
     }
}
