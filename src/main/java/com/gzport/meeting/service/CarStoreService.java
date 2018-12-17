package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.CarStore;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/17.
 */
public interface CarStoreService {
    CarStore save(CarStore barge);
    Iterable<CarStore> saveAll(Iterable<CarStore> barges);
    List<CarStore> getCurrentBargeByTerId(String terId);

    void deleteCurrentBargeByTerId(String terId);
}
