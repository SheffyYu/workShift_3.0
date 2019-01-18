package com.gzport.meeting.service;


import com.gzport.meeting.domain.entity.Throughput;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/10.
 */
public interface ThroughputService  {
    Throughput save(Throughput throughput);
    List<Throughput> getByDate(Date date);
    void deleteByDate(String date);
}
