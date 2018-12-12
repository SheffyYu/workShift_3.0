package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Throughput;
import com.gzport.meeting.repository.ThroughputRepository;
import com.gzport.meeting.service.ThroughputService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/10.
 */
@Service
public class ThroughputServiceImpl implements ThroughputService {

    @Autowired
    ThroughputRepository throughputRepository;

    @Override
    public Throughput save(Throughput throughput) {
        return throughputRepository.save(throughput);
    }

    @Override
    public List<Throughput> getByDate(String date) {
        return throughputRepository.findByDate(date);
    }

    @Override
    @Transactional
    public void deleteByDate(String date) {
        throughputRepository.deleteByDate(date);
    }
}
