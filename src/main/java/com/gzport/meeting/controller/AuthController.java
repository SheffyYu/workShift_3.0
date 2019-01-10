package com.gzport.meeting.controller;

import com.gzport.meeting.domain.AuthConverter;
import com.gzport.meeting.domain.dto.AuthInfo;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.service.AuthService;
import net.huadong.idev.ezui.utils.HdCipher;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/createUser")
    @ResponseBody
    public AuthInfo createAuth(@RequestBody Auth auth){
        auth.setPassword(HdCipher.getMD(auth.getPassword(), "MD5"));
        return authConverter.convert(authService.createAuth(auth));
    }

    @PostMapping("/changePassword")
    @ResponseBody
    public AuthInfo changePassowrd(@RequestBody Auth user){
        Auth auth=authService.findByAccount(SecurityUtils.getSubject().getPrincipal().toString());
        auth.setPassword(HdCipher.getMD(user.getPassword(), "MD5"));
        if(authService.createAuth(auth)!=null){
            return authConverter.convert(auth);
        }else
            return null;
    }
}
