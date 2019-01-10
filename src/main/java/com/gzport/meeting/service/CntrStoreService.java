package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.CntrStore;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface CntrStoreService {
    CntrStore save(CntrStore cntrStore);
    Iterable<CntrStore> saveAll(Iterable<CntrStore> cntrStores);
    List<CntrStore> getCurrentCntrStroeByTerId(String terId);
    List<CntrStore> getCntrStoreByTerIdAndTime(String terId,String date);
    void deleteCurrentBargeByTerId(String terId);
}
