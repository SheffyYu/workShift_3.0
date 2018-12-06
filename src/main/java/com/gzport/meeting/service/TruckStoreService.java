package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.TruckStore;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */

public interface TruckStoreService {
    TruckStore save(TruckStore truckStore);

    Iterable<TruckStore> saveAll(Iterable<TruckStore> truckStores);

    List<TruckStore> findCurrentProByTerID(String terId);
    void deleteCurrentBargeByTerId(String terId);
}
