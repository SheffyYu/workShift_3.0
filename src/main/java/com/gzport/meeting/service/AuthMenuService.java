package com.gzport.meeting.service;

import java.util.List;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/12/1.
 */
public interface AuthMenuService {

    List<Map> findTreeByAccount(String account);
}
