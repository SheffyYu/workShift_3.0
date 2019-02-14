package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.CarStore;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/17.
 */
public interface CarStoreService {
    CarStore save(CarStore barge);
    Iterable<CarStore> saveAll(Iterable<CarStore> barges);
    List<CarStore> getCurrentBargeByTerId(String terId);
    List<CarStore> getBargeByTerIdAndTime(String terId,String date);
    List<CarStore> getCarStoreByDate(Date date);
    List<CarStore> getLastFiveDataByTerCode(String terCode, Pageable pageable);
    void deleteCurrentBargeByTerId(String terId);
}
