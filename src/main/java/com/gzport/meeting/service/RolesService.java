package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Roles;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public interface RolesService {

    Roles create(Roles roles);

    List<Roles> findAll();




    void roleDelete(Roles roles);
}
