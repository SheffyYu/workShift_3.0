package com.gzport.meeting.controller;

import com.gzport.meeting.common.ServletOp;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.LoginLog;
import com.gzport.meeting.service.AuthService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by zhangxiang on 2019/1/17.
 */
@Controller
@CrossOrigin
public class TestDockController {

    @Autowired
    AuthService authService;

    @RequestMapping("/hello")
    public String test(String account,HttpServletRequest request){
        Auth auth=authService.findByAccount(account);
        if(auth!=null){
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(auth.getAccount(), auth.getPassword());
            LoginLog loginLog=new LoginLog();
            loginLog.setUserId(auth.getUserId());
            String ip = ServletOp.getRemoteHost(request);
            loginLog.setIp(ip);
        }
        return "redirect:login/main.html";
    }
}
