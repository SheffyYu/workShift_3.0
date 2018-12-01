package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.LoginLog;
import com.gzport.meeting.repository.LoginLogRepository;
import com.gzport.meeting.service.LoginLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhangxiang on 2018/11/30.
 */
@Service
public class LoginLogServiceImpl implements LoginLogService {

    @Autowired
    LoginLogRepository loginLogRepository;

    @Override
    public LoginLog create(LoginLog loginLog) {
        return loginLogRepository.save(loginLog);
    }
}
