package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.service.AuthService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by zhangxiang on 2018/12/2.
 */

@RestController
@RequestMapping("/login")
public class AuthController {

    @Autowired
    AuthService authService;

    @GetMapping("/getLoginUser")
    public String getLoginUser(){
        System.out.println("user : "+SecurityUtils.getSubject().getPrincipal().toString());
        Auth auth=authService.findByAccount(SecurityUtils.getSubject().getPrincipal().toString());
        System.out.println(auth.getName());
        return auth.getName();
    }
}
