package com.gzport.meeting.service.impl;

import com.gzport.meeting.repository.AuthMenuRepository;
import com.gzport.meeting.service.AuthMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/12/1.
 */
@Service
public class AuthMenuServiceImpl implements AuthMenuService {

    @Autowired
    AuthMenuRepository authMenuRepository;

    @Override
    public List<Map> getTreeByAccount(String account) {
        if("admin".equals(account)){
            return authMenuRepository.getAdminTree();
        }else{
            return authMenuRepository.getTreeByAccount(account);
        }
    }
}
