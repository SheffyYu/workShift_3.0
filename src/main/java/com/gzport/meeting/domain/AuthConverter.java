package com.gzport.meeting.domain;

import com.google.common.base.Converter;
import com.gzport.meeting.domain.dto.AuthInfo;
import com.gzport.meeting.domain.entity.Auth;
import org.springframework.stereotype.Component;

/**
 * Created by zhangxiang on 2018/12/4.
 */
@Component
public class AuthConverter extends Converter<Auth,AuthInfo>{

    @Override
    protected AuthInfo doForward(Auth auth) {
        return new AuthInfo(auth.getName(),auth.getAccount(),auth.getDescription(),auth.getCompany());
    }

    @Override
    protected Auth doBackward(AuthInfo authInfo) {
        return null;
    }
}
