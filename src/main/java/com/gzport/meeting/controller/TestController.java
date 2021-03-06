package com.gzport.meeting.controller;

import com.gzport.meeting.common.Constants;
import com.gzport.meeting.domain.entity.*;
import com.gzport.meeting.domain.vo.DispersionVO;
import com.gzport.meeting.foundation.ConvertToImage;
import com.gzport.meeting.service.*;
import net.huadong.idev.ezui.utils.HdCipher;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;
import redis.clients.jedis.JedisCluster;

import java.util.*;

/**
 * Created by zhangxiang on 2018/11/29.
 */
@RestController
@RequestMapping("/test")
public class TestController {

    public static final String SESSION_PRIVILLEGE = "PrivilegeController";//用户权限
    public static final String SESSION_USER = "user";//用户名
    public static final String SESSION_RANDOMCOD = "randomCod";//随机验证码
    public static final String CAN_VISIT = "canVisit";//


    @Autowired
    AuthService authService;

    @Autowired
    RolesService rolesService;

    @Autowired
    MenuService menuService;

    @Autowired
    RoleMenuService roleMenuService;

    @Autowired
    AuthRoleService authRoleService;

    @Autowired
    AuthMenuService authMenuService;

    @Autowired
    DispersionCargoService dispersionCargoService;

    @Autowired
    DispersionService dispersionService;

    @Autowired
    private RedisTemplate redisTemplate;


    @GetMapping("/login")
    public String testLogin(@RequestParam("account")String accunt,@RequestParam("password") String password) throws Exception {
        authService.checkLogin(accunt,password);
        return "这是一个测试类";
    }

    @PostMapping("/create")
    public Auth create(Auth auth){
        auth.setPassword(HdCipher.getMD(auth.getPassword(), "MD5"));
        return authService.createAuth(auth);
    }

    @PostMapping("/createRoles")
    public Roles createRoles(Roles roles){
        return rolesService.create(roles);
    }

    @PostMapping("/createMenu")
    public Menu createMenu(Menu menu){
        return menuService.create(menu);
    }

    @PostMapping("/createAuthRole")
    public AuthRole createAuthRole(AuthRole authRole){
        return authRoleService.createAuthRole(authRole);
    }

    @PostMapping("/createRoleMenu")
    public RoleMenu createRoleMenu(RoleMenu roleMenu){
        return roleMenuService.save(roleMenu);
    }


    @PostMapping("/createCargo")
    public DispersionCargo createCargo(DispersionCargo dispersionCargo){
        System.out.println();
        return dispersionCargoService.save(dispersionCargo);
    }


    @GetMapping("/user")
    public String test(){
        SecurityUtils.getSubject().isPermitted();
        Auth user = (Auth) SecurityUtils.getSubject().getSession().getAttribute(TestController.SESSION_USER);
        System.out.println("user : "+user.getAccount()+" "+user.getPassword()+"  "+user.getName());
        return "test";
    }

    @GetMapping("/deleteRedis")
    public void deleteRedis(){
        HashMap<Object,Object> map=new HashMap<>();
        Set<String> keys=redisTemplate.keys("*");
        for(String key:keys){
            Object value=redisTemplate.delete(key);
        }
    }

}
