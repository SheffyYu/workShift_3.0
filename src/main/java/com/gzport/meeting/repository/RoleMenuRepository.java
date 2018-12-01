package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.RoleMenu;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2018/12/1.
 */
public interface RoleMenuRepository extends PagingAndSortingRepository<RoleMenu,String> {

     RoleMenu findAllByRoleId(String roleId);
}
