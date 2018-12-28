package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.DailyTerdataLog;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/28.
 */
public interface DailyTerDataLogRepository extends PagingAndSortingRepository<DailyTerdataLog,String> {
    List<DailyTerdataLog> findByStatus(String status);
}
