package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.YearPlanThroughput;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2018/12/26.
 */
public interface YearPlanThroughputRepository extends PagingAndSortingRepository<YearPlanThroughput,String> {
    YearPlanThroughput findByYear(String year);
}
