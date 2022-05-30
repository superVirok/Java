package com.wu.pojo;/*
 * Created by Virok on 2022/4/24
 */

import java.io.Serializable;
import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.stereotype.Component;

@Component("User")
public class User implements Serializable {
    private int userId;  //用户id
    private String userName; //用户姓名
    private String userPassword; //用户密码
    private String userPhone; //用户电话
    private String userEmail; //用户邮箱
    private Integer userRole; //用户角色，0代表管理员,1代表员工,2代表普通用户
    private Integer userStatus; //用户状态,0代表正常，可以登录。1代表禁用，不可登录
    private Date userHiredate;  //入职时间
    private Date userDeparturedate;//离职时间

    public User() {

    }

    public User(int userId, String userName, String userPassword, String userPhone,
                String userEmail, Integer userRole, Integer userStatus, Date userHiredate, Date userDeparturedate) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userPhone = userPhone;
        this.userEmail = userEmail;
        this.userRole = userRole;
        this.userStatus = userStatus;
        this.userHiredate = userHiredate;
        this.userDeparturedate = userDeparturedate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public Integer getUserRole() {
        return userRole;
    }

    public void setUserRole(Integer userRole) {
        this.userRole = userRole;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getUserHiredate() {
        return userHiredate;
    }

    public void setUserHiredate(Date userHiredate) {
        this.userHiredate = userHiredate;
    }

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getUserDeparturedate() {
        return userDeparturedate;
    }

    public void setUserDeparturedate(Date userDeparturedate) {
        this.userDeparturedate = userDeparturedate;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userPassword='" + userPassword + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userRole=" + userRole +
                ", userStatus=" + userStatus +
                ", userHiredate=" + userHiredate +
                ", userDeparturedate=" + userDeparturedate +
                '}';
    }
}
