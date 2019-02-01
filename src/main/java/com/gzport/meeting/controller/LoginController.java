package com.gzport.meeting.controller;

import com.gzport.meeting.common.LoginResult;
import com.gzport.meeting.common.ServletOp;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.InterfaceUser;
import com.gzport.meeting.domain.entity.LoginLog;
import com.gzport.meeting.service.AuthService;
import com.gzport.meeting.service.InterfaceUserService;
import com.gzport.meeting.service.LoginLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.huadong.idev.ezui.utils.HdCipher;
import net.huadong.idev.utils.HdImageCode;
import net.huadong.idev.utils.HdRandomCode;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by zhangxiang on 2018/11/30.
 */
@Controller
@Api(description = "用户登录接口")
public class LoginController {
    public static final String SESSION_PRIVILLEGE = "PrivilegeController";//用户权限
    public static final String SESSION_USER = "user";//用户名
    public static final String SESSION_RANDOMCOD = "randomCod";//随机验证码
    public static final String CAN_VISIT = "canVisit";//
    @Autowired
    AuthService authService;

    @Autowired
    LoginLogService loginLogService;

    @Autowired
    InterfaceUserService interfaceUserService;

    @RequestMapping("/logincontroller/getValidateCode")
    @ApiOperation(value = "获取验证码")
    public void getValidateCode(HttpServletResponse response) throws Exception {
        String rCod = HdRandomCode.getStringCode(4);
        SecurityUtils.getSubject().getSession().setAttribute(LoginController.SESSION_RANDOMCOD, rCod);
        response.setHeader("Pragma", "No-cache");//没有缓存
        response.setHeader("Cache-Control", "no-cache");//没有缓存
        response.setDateHeader("Expires", 0);//设置过期的时间限制
        ImageIO.write(HdImageCode.getImage(120, 40, 255, rCod), "JPEG", response.getOutputStream());
    }


    @GetMapping("/logincontroller/dologin")
    @ResponseBody
    @ApiOperation(value = "校验账号密码")
    public LoginResult doLogin(@RequestParam("account") String account, @RequestParam("password") String password,@RequestParam("validateCode") String validateCode,HttpServletRequest request) {
        String vc = SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_RANDOMCOD).toString();
        if (validateCode==null
                ||validateCode.trim().length()==0
                ||!validateCode.toUpperCase().equals(vc.toUpperCase())) {
            return LoginResult.getInstance(LoginResult.WRONG_VALIDATE_CODE);
        }
        if(authService.findByAccount(account)==null){
            return LoginResult.getInstance(LoginResult.UNKNOW_ACCOUNT);
        }
        if(authService.checkLogin(account,password)!=null) {
//            Subject subject = SecurityUtils.getSubject();
//            UsernamePasswordToken token = new UsernamePasswordToken(account, password);
            LoginLog loginLog=new LoginLog();
            Auth auth=authService.findByAccount(account);
            loginLog.setUserId(auth.getUserId());
            String ip = ServletOp.getRemoteHost(request);
            loginLog.setIp(ip);
            loginLogService.create(loginLog);
            return LoginResult.getInstance(LoginResult.SUCCESS);
        }
        else
            return LoginResult.getInstance(LoginResult.WRONG_PASSWORD);
    }


    //调度系统登录
    @RequestMapping("/shiplogin")
    @ApiOperation(value = "调度系统登录调用接口")
    public String shipLogin(String id,String account,HttpServletRequest request){
        List<InterfaceUser> interfaceUserList=interfaceUserService.findBycentIdAndAccout(id,account);
        Auth auth=null;
        if(interfaceUserList.size()>0) {
            auth = authService.findByUserId(interfaceUserList.get(0).getUserId());
        }
        if(auth!=null){
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(auth.getAccount(), "123");
            token.setRememberMe(true);
            try {
                SecurityUtils.getSubject().login(token);
            } catch (UnknownAccountException uae) {
                //LOG.info("There is no user with username of " + token.getPrincipal());
            } catch (IncorrectCredentialsException ice) {
                //LOG.info("Password for account " + token.getPrincipal() + " was incorrect!");
            } catch (LockedAccountException lae) {
                //LOG.info("The account for username " + token.getPrincipal() + " is locked.  "
                //       + "Please contact your administratornnn to unlock it.");
            } // ... catch more exceptions here (maybe custom ones specific to your application?
            catch (AuthenticationException ae) {
                //unexpected condition?  error?
                ae.printStackTrace();
            }
            SecurityUtils.getSubject().getSession().setAttribute(LoginController.SESSION_USER, auth);
            LoginLog loginLog=new LoginLog();
            loginLog.setUserId(auth.getUserId());
            String ip = ServletOp.getRemoteHost(request);
            loginLog.setIp(ip);
        }
        return "redirect:login/main.html";
    }

    @GetMapping("/logincontroller/logout")
    @ResponseBody
    @ApiOperation(value = "退出登录接口")
    public Response logout(HttpServletRequest req, HttpServletResponse resp){
        SecurityUtils.getSubject().logout();
        SecurityUtils.getSubject().getSession().removeAttribute(LoginController.SESSION_USER);
        try {
            resp.sendRedirect("/index.html");
        } catch (IOException ex) {
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Response.ok().build();
    }
}
