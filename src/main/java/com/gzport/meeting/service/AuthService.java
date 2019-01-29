package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Auth;
import net.huadong.idev.ezui.HdEzuiDatagridData;
import net.huadong.idev.ezui.HdEzuiQueryParams;
import net.huadong.idev.ezui.HdEzuiSaveDatagridData;
import net.huadong.idev.hdmessagecode.HdMessageCode;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public interface AuthService {
    List<Auth> findAll();
    Auth checkLogin(String accout,String password);
    Auth findByAccount(String account);
    HdMessageCode ezuiSave(HdEzuiSaveDatagridData data);
    HdEzuiDatagridData ezuiFind(HdEzuiQueryParams hdEzuiQueryParams);
    Auth createAuth(Auth auth);
    Auth findByUserId(String userId);
}
