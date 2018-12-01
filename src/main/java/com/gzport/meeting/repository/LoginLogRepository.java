package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.LoginLog;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2018/11/30.
 */
public interface LoginLogRepository  extends PagingAndSortingRepository<LoginLog,String>{

}
