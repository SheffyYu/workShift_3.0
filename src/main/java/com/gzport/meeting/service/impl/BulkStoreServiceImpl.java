package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.repository.BulkStoreRepository;
import com.gzport.meeting.service.BulkStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public List<BulkStore> getCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-mm-dd").format(new Date());
        return bulkStoreRepository.findCurrentDataByWharf(date,terId);
    }
}
