package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.RoleMenu;

import java.util.List;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/12/1.
 */

public interface RoleMenuService {

    RoleMenu save(RoleMenu roleMenu);

    void delete(RoleMenu roleMenu);

    List<Map> findRoleMenu(String account);

}
