package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Menu;
import com.gzport.meeting.repository.hdrepository.HDMenuRepository;
import com.gzport.meeting.service.MenuService;
import net.huadong.idev.hdmessagecode.HdMessageCode;
import net.huadong.tech.springboot.core.HdEzuiDatagridData;
import net.huadong.tech.springboot.core.HdEzuiQueryParams;
import net.huadong.tech.springboot.core.HdEzuiSaveDatagridData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhangxiang on 2018/11/30.
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    HDMenuRepository hdMenuRepository;

    @Override
    public HdMessageCode ezuiSave(HdEzuiSaveDatagridData<Menu> data) {
        return hdMenuRepository.save(data);
    }

    @Override
    public HdEzuiDatagridData ezuiFind(HdEzuiQueryParams hdEzuiQueryParams) {
        return hdMenuRepository.ezuiFind(hdEzuiQueryParams);
    }
}
