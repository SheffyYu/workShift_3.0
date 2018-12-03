package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.AuthMenu;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;
import java.util.Map;

/**
 * Created by zhangxiang on 2018/12/2.
 */

public interface AuthMenuRepository extends PagingAndSortingRepository<AuthMenu,String> {

    @Modifying
    @Query(value = "SELECT  t.ID, t.PARENT_ID, t.TEXT, t.URL,t.DEFAULT_URL, level    FROM ( select distinct  ID,PARENT_ID,TEXT, URL ,DEFAULT_URL from VJ_AUTHMENU WHERE account = ?1) T START WITH t.PARENT_ID='0' CONNECT BY prior  t.id=t.PARENT_ID   ORDER BY LEVEL, parent_id",nativeQuery = true)
    List<Map> getTreeByAccount(String account);

    @Modifying
    @Query(value = "SELECT  t.ID, t.PARENT_ID, t.TEXT, t.URL,t.DEFAULT_URL, level    FROM ( select distinct  ID,PARENT_ID,TEXT, URL,DEFAULT_URL from VJ_AUTHMENU ) T START WITH t.PARENT_ID='0' CONNECT BY prior  t.id=t.PARENT_ID   ORDER BY LEVEL, parent_id",nativeQuery = true)
    List<Map> getAdminTree();
}
