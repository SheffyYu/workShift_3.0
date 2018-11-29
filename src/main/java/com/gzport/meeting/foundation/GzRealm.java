package com.gzport.meeting.foundation;

import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.service.AuthService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public class GzRealm extends AuthorizingRealm {

    @Autowired
    AuthService authService;

    public GzRealm(){
        setName("GzRealm");
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
         SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
         return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;

        System.out.println("shiro执行登录");

        Auth user = authService.findByAccount(token.getUsername());
        if (user != null) {
            return new SimpleAuthenticationInfo(user.getAccount(), user.getPassword(), getName());
        } else {
            return null;
        }
    }
}
