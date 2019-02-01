package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.RoleMenu;
import com.gzport.meeting.service.AuthMenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
@Api(value = "/login", description = "用户登录调用接口")
public class AuthMenuController {

    @Autowired
    AuthMenuService authMenuService;

    @ApiOperation(value = "获得用户菜单权限树",notes = "获得用户菜单权限树")
    @GetMapping("/getMenuForTree")
    public List<Map> getMenu(){
        return authMenuService.getTreeByAccount(SecurityUtils.getSubject().getPrincipal().toString());
    }
}
