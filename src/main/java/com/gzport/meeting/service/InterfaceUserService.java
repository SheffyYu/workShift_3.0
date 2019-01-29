package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.InterfaceUser;

import java.util.List;

/**
 * Created by zhangxiang on 2019/1/28.
 */
public interface InterfaceUserService {
    List<InterfaceUser> findBycentIdAndAccout(String id, String account);


}
