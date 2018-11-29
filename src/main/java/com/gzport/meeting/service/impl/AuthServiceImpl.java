package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.repository.AuthRepository;
import com.gzport.meeting.service.AuthService;
import net.huadong.idev.ezui.HdEzuiSaveDatagridData;
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
        SecurityUtils.getSubject().login(token);
        return authRepository.findByAccountAndPassword(accout,password);
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
