package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.BargeXS;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface BargeXSService {
    BargeXS save(BargeXS barge);
    Iterable<BargeXS> saveAll(Iterable<BargeXS> barges);
    List<BargeXS> getCurrentBargeByTerId(String terId);
    List<BargeXS> getBargeByTerIdAndTime(String terId,String time);
    List<BargeXS> getBargeByDate(Date date);
    void deleteCurrentBargeByTerId(String terId);
}
