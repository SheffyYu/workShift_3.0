package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.CntrStore;
import com.gzport.meeting.repository.CntrStoreRepsitory;
import com.gzport.meeting.service.CntrStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
@Service
public class CntrStoreServiceImpl implements CntrStoreService {

    @Autowired
    CntrStoreRepsitory cntrStoreRepsitory;

    @Override
    public CntrStore save(CntrStore cntrStore) {
        return cntrStoreRepsitory.save(cntrStore);
    }

    @Override
    public Iterable<CntrStore> saveAll(Iterable<CntrStore> cntrStores) {
        return cntrStoreRepsitory.saveAll(cntrStores);
    }

    @Override
    public List<CntrStore> getCurrentCntrStroeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-mm-dd").format(new Date());
        return cntrStoreRepsitory.findCurrentDataByWharf(date,terId);
    }
}
