package com.gzport.meeting.controller;

import com.gzport.meeting.domain.AuthConverter;
import com.gzport.meeting.domain.dto.AuthInfo;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.service.AuthService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import net.huadong.idev.ezui.utils.HdCipher;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
/**
 * Created by zhangxiang on 2018/12/2.
 */

@RestController
@Api(value = "/login", description = "用户登录调用接口")
@RequestMapping("/login")
public class AuthController {

    @Autowired
    AuthService authService;

    @Autowired
    AuthConverter authConverter;

    @GetMapping("/getLoginUser")
    @ApiOperation(value = "获得登录用户信息",notes = "获得登录用户信息")
    public AuthInfo getLoginUser(){
        Auth auth=authService.findByAccount(SecurityUtils.getSubject().getPrincipal().toString());
        return authConverter.convert(auth);
    }

    @PostMapping("/createUser")
    @ResponseBody
    @ApiOperation(value = "创建用户",notes = "创建用户")
    @ApiImplicitParam(name = "auth", value = "用户信息", required = true, dataType = "Auth")
    public AuthInfo createAuth(@RequestBody Auth auth){
        auth.setPassword(HdCipher.getMD(auth.getPassword(), "MD5"));
        return authConverter.convert(authService.createAuth(auth));
    }

    @PostMapping("/changePassword")
    @ResponseBody
    @ApiOperation(value = "修改密码",notes = "修改密码")
    public AuthInfo changePassowrd(@RequestBody Auth user){
        Auth auth=authService.findByAccount(SecurityUtils.getSubject().getPrincipal().toString());
        auth.setPassword(HdCipher.getMD(user.getPassword(), "MD5"));
        if(authService.createAuth(auth)!=null){
            return authConverter.convert(auth);
        }else
            return null;
    }
}
