package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.InterfaceUser;
import com.gzport.meeting.repository.InterfaceUserRepository;
import com.gzport.meeting.service.InterfaceUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhangxiang on 2019/1/28.
 */
@Service
public class InterfaceUserServiceImpl implements InterfaceUserService {

    @Autowired
    InterfaceUserRepository interfaceUserRepository;

    @Override
    public List<InterfaceUser> findBycentIdAndAccout(String id, String account) {
        return interfaceUserRepository.findByCentUserIdAndCentUserAccout(id,account);
    }
}
