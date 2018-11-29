package com.gzport.meeting.controller;

import com.gzport.meeting.common.Constants;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.service.AuthService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.JedisCluster;

/**
 * Created by zhangxiang on 2018/11/29.
 */
@RestController
@RequestMapping("/test")
public class TestController {

    @Autowired
    AuthService authService;

    @GetMapping("/login")
    public String testLogin() throws Exception {
        String username="test";
        String password="test";
        authService.checkLogin(username,password);
        return "这是一个测试类";
    }
}
