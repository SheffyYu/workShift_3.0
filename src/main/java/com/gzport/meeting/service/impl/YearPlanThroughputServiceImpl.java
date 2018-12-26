package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.YearPlanThroughput;
import com.gzport.meeting.repository.YearPlanThroughputRepository;
import com.gzport.meeting.service.YearPlanThroughputService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhangxiang on 2018/12/26.
 */
@Service
public class YearPlanThroughputServiceImpl implements YearPlanThroughputService {
    @Autowired
    YearPlanThroughputRepository yearPlanThroughputRepository;

    @Override
    public YearPlanThroughput save(YearPlanThroughput yearPlanThroughput) {
        return yearPlanThroughputRepository.save(yearPlanThroughput);
    }

    @Override
    public YearPlanThroughput findByYear(String year) {
        return yearPlanThroughputRepository.findByYear(year);
    }
}
