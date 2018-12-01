package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.RoleMenu;
import com.gzport.meeting.domain.entity.Roles;
import com.gzport.meeting.repository.AuthRepository;
import com.gzport.meeting.repository.RoleMenuRepository;
import com.gzport.meeting.repository.RolesRepository;
import com.gzport.meeting.service.RoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/12/1.
 */
@Service
public class RoleMenuServiceImpl implements RoleMenuService {

    @Autowired
    RoleMenuRepository roleMenuRepository;

    @Autowired
    RolesRepository rolesRepository;

    @Autowired
    AuthRepository authRepository;


    @Override
    public RoleMenu save(RoleMenu roleMenu) {
        return roleMenuRepository.save(roleMenu);
    }

    @Override
    public void delete(RoleMenu roleMenu) {
        roleMenuRepository.delete(roleMenu);
    }

    @Override
    public List<Map> findRoleMenu(String account) {
        Auth auth=authRepository.findByAccount(account);
        return null;
    }
}
