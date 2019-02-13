package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Barge;
import com.gzport.meeting.repository.BargeRepository;
import com.gzport.meeting.service.BargeService;
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
public class BargeServiceImpl implements BargeService {

    @Autowired
    BargeRepository bargeRepository;

    @Override
    public Barge save(Barge barge) {
        return bargeRepository.save(barge);
    }

    @Override
    public Iterable<Barge> saveAll(Iterable<Barge> barges) {
        return bargeRepository.saveAll(barges);
    }

    @Override
    public List<Barge> getCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bargeRepository.findCurrentDataByWharf(time,terId);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<Barge> getBargeByTerIdAndTime(String terId, String date) {
        Date time = null;
        try {
            time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bargeRepository.findByTimeAndWharf(time,terId);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Barge> getLastFiveDataByTerCode(String terCode, Pageable pageable) {
        return bargeRepository.findByTerCode(terCode,pageable);
    }

    @Override
    public List<Barge> getBargeByDate(Date date) {
        return bargeRepository.findByTime(date);
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            bargeRepository.deleteCurrentDataByWharf(time,terId);
        }catch (ParseException e){
        }
    }
}
