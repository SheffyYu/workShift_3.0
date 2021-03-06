package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.CntrStore;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface CntrStoreService {
    CntrStore save(CntrStore cntrStore);
    Iterable<CntrStore> saveAll(Iterable<CntrStore> cntrStores);
    List<CntrStore> getCurrentCntrStroeByTerId(String terId);
    List<CntrStore> getCntrStoreByTerIdAndTime(String terId,String date);
    List<CntrStore> getCntrSotreByDate(Date date);
    List<CntrStore> getPaginDataByTerCode(String terCode, Pageable pageable);
    void deleteCurrentBargeByTerId(String terId);
}
