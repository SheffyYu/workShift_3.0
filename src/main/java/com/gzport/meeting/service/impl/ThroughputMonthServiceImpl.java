package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.ThroughputMonth;
import com.gzport.meeting.repository.ThroughputMonthRepository;
import com.gzport.meeting.service.ThroughputMonthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhangxiang on 2019/2/1.
 */
@Service
public class ThroughputMonthServiceImpl implements ThroughputMonthService {
    @Autowired
    ThroughputMonthRepository throughputMonthRepository;

    @Override
    public List<ThroughputMonth> findAll() {
        return throughputMonthRepository.findAll();
    }
}
