package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.AuthRole;
import com.gzport.meeting.repository.AuthRoleRepository;
import com.gzport.meeting.service.AuthRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
@Service
public class AuthRoleServiceImpl implements AuthRoleService{

    @Autowired
    AuthRoleRepository authRoleRepository;

    @Override
    public AuthRole createAuthRole(AuthRole authRole) {
        return authRoleRepository.save(authRole);
    }

    @Override
    public List<AuthRole> findAll() {
        return authRoleRepository.findAll();
    }

    @Override
    public List<AuthRole> findByAuthId(String authId) {
        return authRoleRepository.findAllByAuthId(authId);
    }

    @Override
    public void deleteAuthRole(String authId) {
        authRoleRepository.deleteByAuthId(authId);
    }
}
