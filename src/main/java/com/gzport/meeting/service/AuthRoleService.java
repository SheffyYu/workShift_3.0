package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.AuthRole;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public interface AuthRoleService {
    AuthRole createAuthRole(AuthRole authRole);
    List<AuthRole> findAll();
    List<AuthRole> findByAuthId(String authId);
    void deleteAuthRole(String authId);
}
