package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import com.gzport.meeting.repository.BulkStoreRepository;
import com.gzport.meeting.service.BulkStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.ParseException;
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
    public List<BulkStore> getBulkByTime(String date) {
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bulkStoreRepository.findBulkBytime(time);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<BulkStore> getCurrentBulkByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bulkStoreRepository.findCurrentDataByWharf(time,terId);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<BulkStoreVO> getBulkStoreVOByTime(Date time) {
        return bulkStoreRepository.findBulkVOBytime(time);
    }


    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            bulkStoreRepository.deleteCurrentDataByWharf(time,terId);
        }catch (ParseException e){
        }
    }
}
