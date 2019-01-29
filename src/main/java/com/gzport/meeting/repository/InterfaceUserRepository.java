package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.InterfaceUser;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2019/1/28.
 */
public interface InterfaceUserRepository extends PagingAndSortingRepository<InterfaceUser,String> {

    @Modifying
    @Query(value = "SELECT t FROM InterfaceUser t  WHERE CENT_USER_ID =?1 AND CENT_USER_ACCOUNT=?2")
    List<InterfaceUser> findByCentUserIdAndCentUserAccout(String centUserId, String centUserAccout);


}
