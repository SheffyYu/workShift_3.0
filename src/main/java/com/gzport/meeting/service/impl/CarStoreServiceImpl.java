package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.CarStore;
import com.gzport.meeting.repository.CarStoreRepository;
import com.gzport.meeting.service.CarStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/17.
 */
@Service
public class CarStoreServiceImpl implements CarStoreService {

    @Autowired
    CarStoreRepository carStoreRepository;

    @Override
    public CarStore save(CarStore barge) {
        return carStoreRepository.save(barge);
    }

    @Override
    public Iterable<CarStore> saveAll(Iterable<CarStore> barges) {
        return carStoreRepository.saveAll(barges);
    }

    @Override
    public List<CarStore> getCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return carStoreRepository.findCurrentDataByWharf(date,terId);
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        carStoreRepository.deleteCurrentDataByWharf(date,terId);
    }
}
