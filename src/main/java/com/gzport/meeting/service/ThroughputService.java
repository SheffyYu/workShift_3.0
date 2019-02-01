package com.gzport.meeting.service;


import com.gzport.meeting.domain.entity.Throughput;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/10.
 */
public interface ThroughputService  {
    Throughput save(Throughput throughput);
    List<Throughput> getByDate(Date date);
    List<Throughput> findDateMax();
    Page<Throughput> findThroughputforscreen(Pageable pageable);
    void deleteByDate(String date);
}
