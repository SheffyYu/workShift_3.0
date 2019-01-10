package com.gzport.meeting.config;

import com.gzport.meeting.filter.LoginFilter;
import com.gzport.meeting.foundation.GzRealm;
import org.apache.shiro.authc.credential.Md5CredentialsMatcher;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.filter.authc.LogoutFilter;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import javax.servlet.Filter;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/11/29.
 */

@Configuration
public class ShiroConfiguration {

    @Bean(name = "lifecycleBeanPostProcessor")
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    @Bean(name = "securityManager")
    public DefaultWebSecurityManager securityManager(){
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(shiroRealm());
        securityManager.setCacheManager(ehCacheManager());
        return securityManager;
    }

    @Bean(name = "ehCacheManager")
    @DependsOn("lifecycleBeanPostProcessor")
    public EhCacheManager ehCacheManager(){
        EhCacheManager ehCacheManager = new EhCacheManager();
        return ehCacheManager;
    }

    @Bean(name = "shiroRealm")
    @DependsOn("lifecycleBeanPostProcessor")
    public GzRealm shiroRealm() {
        GzRealm realm = new GzRealm();
        realm.setCredentialsMatcher(hashedCredentialsMatcher());
        return realm;
    }

    @Bean(name = "hashedCredentialsMatcher")
    public Md5CredentialsMatcher hashedCredentialsMatcher() {
        Md5CredentialsMatcher credentialsMatcher = new Md5CredentialsMatcher();
//		credentialsMatcher.setHashAlgorithmName("MD5");
//		credentialsMatcher.setHashIterations(2);
//		credentialsMatcher.setStoredCredentialsHexEncoded(true);
        return credentialsMatcher;
    }



    @Bean
    public ShiroFilterFactoryBean shiroFilter() {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager());
        shiroFilterFactoryBean.setLoginUrl("/login");
        // 登录成功后要跳转的链接
         shiroFilterFactoryBean.setSuccessUrl("/index");
        // 未授权界面;
        shiroFilterFactoryBean.setUnauthorizedUrl("/403");

        //自定义拦截器
        Map<String, Filter> filtersMap = new LinkedHashMap<String, Filter>();

        LogoutFilter logoutFilter = new LogoutFilter();
        logoutFilter.setRedirectUrl("/login");
        filtersMap.put("logout", logoutFilter);
        filtersMap.put("login", new LoginFilter());
        shiroFilterFactoryBean.setFilters(filtersMap);
        //限制同一帐号同时在线的个数。
        //filtersMap.put("kickout", kickoutSessionControlFilter());
        shiroFilterFactoryBean.setFilters(filtersMap);
        Map<String, String> filterChainDefinitionManager = new LinkedHashMap<String, String>();
        filterChainDefinitionManager.put("/logout", "logout");
        filterChainDefinitionManager.put("/login/**", "login");
//		filterChainDefinitionManager.put("/wx/", "login");
//        filterChainDefinitionManager.put("/webresources/login/**","login");
//		filterChainDefinitionManager.put("/user/**", "authc,roles[user]");
//		filterChainDefinitionManager.put("/shop/**", "authc,roles[shop]");
//		filterChainDefinitionManager.put("/admin/**", "authc,roles[admin]");
        filterChainDefinitionManager.put("/**", "anon");
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionManager);

        shiroFilterFactoryBean.setLoginUrl("/index.html");
        shiroFilterFactoryBean.setSuccessUrl("/login");
        shiroFilterFactoryBean.setUnauthorizedUrl("/403");

        return shiroFilterFactoryBean;
    }
}
