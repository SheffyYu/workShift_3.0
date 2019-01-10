package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.BargeXS;
import com.gzport.meeting.repository.BargeXSRepository;
import com.gzport.meeting.service.BargeXSService;
import org.springframework.beans.factory.annotation.Autowired;
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
public class BargeXSServiceImpl implements BargeXSService {

    @Autowired
    BargeXSRepository bargeXSRepository;

    @Override
    public BargeXS save(BargeXS barge) {
        return bargeXSRepository.save(barge);
    }

    @Override
    public Iterable<BargeXS> saveAll(Iterable<BargeXS> barges) {
        return bargeXSRepository.saveAll(barges);
    }

    @Override
    public List<BargeXS> getCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bargeXSRepository.findCurrentDataByWharf(time,terId);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<BargeXS> getBargeByTerIdAndTime(String terId, String date) {
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bargeXSRepository.findByTimeAndWharf(time,terId);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            bargeXSRepository.deleteCurrentDataByWharf(time,terId);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
