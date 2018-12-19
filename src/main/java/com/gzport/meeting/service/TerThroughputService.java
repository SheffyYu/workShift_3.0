package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.TerThroughput;

import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/19.
 */
public interface TerThroughputService {

    TerThroughput save(TerThroughput terThroughput);
    Iterable<TerThroughput> saveAll(Iterable<TerThroughput> terThroughputs);
    List<TerThroughput> getTerThroughBytime(String time);
    List<TerThroughput> getCurrentTerThroughputByTerId(String terId);
    void deleteCurrentTerThroughputByTerId(String terId);
    void deleteTerThroughputByDate(String date);
}
