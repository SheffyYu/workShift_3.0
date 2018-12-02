package com.gzport.meeting.controller;

import com.gzport.meeting.service.AuthMenuService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/12/2.
 */

@RestController
@RequestMapping("/login")
public class AuthMenuController {

    @Autowired
    AuthMenuService authMenuService;

    @GetMapping("/getMenuForTree")
    public List<Map> getMenu(){
        return authMenuService.getTreeByAccount(SecurityUtils.getSubject().getPrincipal().toString());
    }
}
