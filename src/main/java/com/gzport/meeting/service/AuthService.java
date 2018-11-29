package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Auth;
import net.huadong.idev.ezui.HdEzuiDatagridData;
import net.huadong.idev.ezui.HdEzuiSaveDatagridData;
import net.huadong.idev.hdmessagecode.HdMessageCode;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public interface AuthService {
    List<Auth> findAll();
    Auth checkLogin(String accout,String password) throws Exception;
    Auth findByAccount(String account);
    HdMessageCode ezuiSave(HdEzuiSaveDatagridData data);
    Auth createAuth(Auth auth);
}
