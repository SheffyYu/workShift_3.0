package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Roles;
import net.huadong.idev.ezui.HdEzuiDatagridData;
import net.huadong.idev.ezui.HdEzuiQueryParams;
import net.huadong.idev.ezui.HdEzuiSaveDatagridData;
import net.huadong.idev.hdmessagecode.HdMessageCode;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public interface RolesService {

    Roles create(Roles roles);

    List<Roles> findAll();

    HdMessageCode ezuiSave(HdEzuiSaveDatagridData data);

    HdEzuiDatagridData ezuiFind(HdEzuiQueryParams hdEzuiQueryParams);

    void roleDelete(Roles roles);
}
