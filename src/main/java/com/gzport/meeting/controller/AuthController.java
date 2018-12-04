package com.gzport.meeting.controller;

import com.gzport.meeting.domain.AuthConverter;
import com.gzport.meeting.domain.dto.AuthInfo;
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

    @Autowired
    AuthConverter authConverter;

    @GetMapping("/getLoginUser")
    public AuthInfo getLoginUser(){
        Auth auth=authService.findByAccount(SecurityUtils.getSubject().getPrincipal().toString());
        return authConverter.convert(auth);
    }
}
