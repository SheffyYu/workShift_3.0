package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Roles;
import com.gzport.meeting.repository.RolesRepository;
import com.gzport.meeting.service.RolesService;
import net.huadong.idev.ezui.HdEzuiDatagridData;
import net.huadong.idev.ezui.HdEzuiQueryParams;
import net.huadong.idev.ezui.HdEzuiSaveDatagridData;
import net.huadong.idev.hdmessagecode.HdMessageCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/30.
 */
@Service
public class RolesServiceImpl implements RolesService {

    @Autowired
    RolesRepository rolesRepository;


    @Override
    public Roles create(Roles roles) {
        return rolesRepository.save(roles);
    }

    @Override
    public List<Roles> findAll() {
        return null;
    }

    @Override
    public HdMessageCode ezuiSave(HdEzuiSaveDatagridData data) {
        return null;
    }

    @Override
    public HdEzuiDatagridData ezuiFind(HdEzuiQueryParams hdEzuiQueryParams) {
        return null;
    }


    @Override
    public void roleDelete(Roles roles) {

    }
}
