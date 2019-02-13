package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.CntrStore;
import com.gzport.meeting.repository.CntrStoreRepsitory;
import com.gzport.meeting.service.CntrStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.ParseException;
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
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return cntrStoreRepsitory.findCurrentDataByWharf(time,terId);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<CntrStore> getCntrStoreByTerIdAndTime(String terId, String date) {
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return cntrStoreRepsitory.findByTimeAndWharf(time,terId);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<CntrStore> getCntrSotreByDate(Date date) {
        return cntrStoreRepsitory.findByTime(date);
    }

    @Override
    public List<CntrStore> getPaginDataByTerCode(String terCode, Pageable pageable) {
        return cntrStoreRepsitory.findByTerCode(terCode,pageable);
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            cntrStoreRepsitory.deleteCurrentDataByWharf(time,terId);
        }catch (ParseException e){
        }
    }
}
