package com.gzport.meeting.service.impl;

import com.gzport.meeting.controller.TestController;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.repository.AuthRepository;
import com.gzport.meeting.service.AuthService;
import net.huadong.idev.ezui.HdEzuiSaveDatagridData;
import net.huadong.idev.ezui.utils.HdCipher;
import net.huadong.idev.hdmessagecode.HdMessageCode;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    AuthRepository authRepository;

    @Override
    public List<Auth> findAll() {
        return authRepository.findAll();
    }

    @Override
    public Auth checkLogin(String accout, String password) throws Exception {
        Subject currentUser = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(accout, password);
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
        password= HdCipher.getMD(password, "MD5");
        Auth user=authRepository.findByAccountAndPassword(accout,password);
        SecurityUtils.getSubject().getSession().setAttribute(TestController.SESSION_USER, user);
        return user;
    }

    @Override
    public Auth findByAccount(String account) {
        return authRepository.findByAccount(account);
    }

    @Override
    public HdMessageCode ezuiSave(HdEzuiSaveDatagridData data) {
        return null;
    }

    @Override
    public Auth createAuth(Auth auth) {
        return authRepository.save(auth);
    }
}
