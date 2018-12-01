package com.gzport.meeting.controller;

import com.gzport.meeting.common.LoginResult;
import com.gzport.meeting.common.ServletOp;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.LoginLog;
import com.gzport.meeting.service.AuthService;
import com.gzport.meeting.service.LoginLogService;
import net.huadong.idev.ezui.utils.HdCipher;
import net.huadong.idev.utils.HdImageCode;
import net.huadong.idev.utils.HdRandomCode;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by zhangxiang on 2018/11/30.
 */
@RestController
@RequestMapping("/logincontroller")
public class LoginController {
    public static final String SESSION_PRIVILLEGE = "PrivilegeController";//用户权限
    public static final String SESSION_USER = "user";//用户名
    public static final String SESSION_RANDOMCOD = "randomCod";//随机验证码
    public static final String CAN_VISIT = "canVisit";//
    @Autowired
    AuthService authService;

    @Autowired
    LoginLogService loginLogService;

    @RequestMapping("/getValidateCode")
    public void getValidateCode(HttpServletResponse response) throws Exception {
        String rCod = HdRandomCode.getStringCode(4);
        SecurityUtils.getSubject().getSession().setAttribute(LoginController.SESSION_RANDOMCOD, rCod);
        response.setHeader("Pragma", "No-cache");//没有缓存
        response.setHeader("Cache-Control", "no-cache");//没有缓存
        response.setDateHeader("Expires", 0);//设置过期的时间限制
        ImageIO.write(HdImageCode.getImage(120, 40, 255, rCod), "JPEG", response.getOutputStream());
    }


    @GetMapping("/dologin")
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

    @GetMapping("/logout")
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
