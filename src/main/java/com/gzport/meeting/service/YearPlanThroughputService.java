package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.YearPlanThroughput;

/**
 * Created by zhangxiang on 2018/12/26.
 */
public interface YearPlanThroughputService {
    YearPlanThroughput save(YearPlanThroughput yearPlanThroughput);
    YearPlanThroughput findByYear(String year);
}
