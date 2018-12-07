package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.repository.BulkStoreRepository;
import com.gzport.meeting.service.BulkStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/5.
 */

@Service
public class BulkStoreServiceImpl implements BulkStoreService {

    @Autowired
    BulkStoreRepository bulkStoreRepository;

    @Override
    public BulkStore save(BulkStore barge) {
        return bulkStoreRepository.save(barge);
    }

    @Override
    public Iterable<BulkStore> saveAll(Iterable<BulkStore> barges) {
        return bulkStoreRepository.saveAll(barges);
    }

    @Override
    public List<BulkStore> getBulkByTime(String time) {
        return bulkStoreRepository.findBulkBytime(time);
    }

    @Override
    public List<BulkStore> getCurrentBulkByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return bulkStoreRepository.findCurrentDataByWharf(date,terId);
    }


    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        bulkStoreRepository.deleteCurrentDataByWharf(date,terId);
    }
}
