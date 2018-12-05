package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.BargeXS;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface BargeXSService {
    BargeXS save(BargeXS barge);
    Iterable<BargeXS> saveAll(Iterable<BargeXS> barges);
    List<BargeXS> getCurrentBargeByTerId(String terId);
}
