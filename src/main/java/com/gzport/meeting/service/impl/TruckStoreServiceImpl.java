package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.TruckStore;
import com.gzport.meeting.repository.TruckStoreRepository;
import com.gzport.meeting.service.TruckStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
@Service
public class TruckStoreServiceImpl implements TruckStoreService {

    @Autowired
    TruckStoreRepository truckStoreRepository;

    @Override
    public TruckStore save(TruckStore truckStore) {
        return truckStoreRepository.save(truckStore);
    }

    @Override
    public Iterable<TruckStore> saveAll(Iterable<TruckStore> truckStores) {
        return truckStoreRepository.saveAll(truckStores);
    }

    @Override
    public List<TruckStore> findCurrentProByTerID(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return truckStoreRepository.findCurrentDataByWharf(date,terId);
    }

    @Override
    public List<TruckStore> findProByTerIdAndTime(String terId, String date) {
        return truckStoreRepository.findCurrentDataByWharf(date,terId);
    }

    @Override
    public List<TruckStore> findProByTerIdAndDate(String terId, Date date) {
        return truckStoreRepository.findByDateAndTerCode(date,terId);
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        truckStoreRepository.deleteCurrentDataByWharf(date,terId);
    }
}
