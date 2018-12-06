package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Barge;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface BargeService {
    Barge save(Barge barge);
    Iterable<Barge> saveAll(Iterable<Barge> barges);
    List<Barge> getCurrentBargeByTerId(String terId);

    void deleteCurrentBargeByTerId(String terId);
}
