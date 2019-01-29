package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Auth;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public interface AuthRepository extends PagingAndSortingRepository<Auth,String>{

    Auth findByUserId(String userId);
    List<Auth> findAll();
    Auth findByAccount(String account);
    Auth findByAccountAndPassword(String account,String password);
}
