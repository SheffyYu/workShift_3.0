package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Barge;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface BargeService {
    Barge save(Barge barge);
    Iterable<Barge> saveAll(Iterable<Barge> barges);
    List<Barge> getCurrentBargeByTerId(String terId);
    List<Barge> getBargeByTerIdAndTime(String terId,String time);
    List<Barge> getLastFiveDataByTerCode(String terCode, Pageable pageable);
    List<Barge> getBargeByDate(Date date);
    void deleteCurrentBargeByTerId(String terId);
}
