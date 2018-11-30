package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Menu;
import net.huadong.idev.hdmessagecode.HdMessageCode;
import net.huadong.tech.springboot.core.HdEzuiDatagridData;
import net.huadong.tech.springboot.core.HdEzuiQueryParams;
import net.huadong.tech.springboot.core.HdEzuiSaveDatagridData;

/**
 * Created by zhangxiang on 2018/11/30.
 */

public interface MenuService {
    HdMessageCode ezuiSave(HdEzuiSaveDatagridData<Menu> data);
    HdEzuiDatagridData ezuiFind(HdEzuiQueryParams hdEzuiQueryParams);
}
