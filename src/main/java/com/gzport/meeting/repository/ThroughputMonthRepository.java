package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.ThroughputMonth;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2019/2/1.
 */
public interface ThroughputMonthRepository extends PagingAndSortingRepository<ThroughputMonth,String> {
    List<ThroughputMonth> findAll();
}
