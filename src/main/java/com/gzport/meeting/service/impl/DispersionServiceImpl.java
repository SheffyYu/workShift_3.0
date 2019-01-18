package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.repository.DispersionRepository;
import com.gzport.meeting.service.DispersionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/3.
 */
@Service
public class DispersionServiceImpl implements DispersionService {

    @Autowired
    DispersionRepository dispersionRepository;
    @Override
    public Dispersion save(Dispersion dispersion) {
        return dispersionRepository.save(dispersion);
    }

    @Override
    public List<Dispersion> findCurrentDispersionByWharf(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return dispersionRepository.findCurrentDataByWharf(time,terId);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<Dispersion> findDispersionByWharfAndTime(String terId, String date) {
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return dispersionRepository.findDataByTimeAndWharf(time,terId);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Dispersion> findDispersionByDate(Date date) {
        return dispersionRepository.findDataByDate(date);
    }

    @Override
    public Iterable<Dispersion> saveInterable(Iterable<Dispersion> dispersions) {
        return dispersionRepository.saveAll(dispersions);
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            dispersionRepository.deleteCurrentDataByWharf(time,terId);
        }catch (ParseException e){

        }
    }


}
