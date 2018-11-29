package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.AuthRole;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public interface AuthRoleRepository extends PagingAndSortingRepository<AuthRole,String>{
    List<AuthRole> findAll();
    List<AuthRole> findAllByAuthId(String authId);
    void deleteByAuthId(String authId);
}
