package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.TerThroughput;
import com.gzport.meeting.repository.TerThroughputRepository;
import com.gzport.meeting.service.TerThroughputService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/19.
 */
@Service
public class TerThroughputServiceImpl implements TerThroughputService {

    @Autowired
    TerThroughputRepository terThroughputRepository;

    @Override
    public TerThroughput save(TerThroughput terThroughput) {
        return terThroughputRepository.save(terThroughput);
    }

    @Override
    public Iterable<TerThroughput> saveAll(Iterable<TerThroughput> terThroughputs) {
        return terThroughputRepository.saveAll(terThroughputs);
    }

    @Override
    public List<TerThroughput> getTerThroughBytime(String date) {
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return terThroughputRepository.findTerThroughputBytime(time);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<TerThroughput> getCurrentTerThroughputByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return terThroughputRepository.findCurrentDataByWharf(time,terId);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    @Transactional
    public void deleteCurrentTerThroughputByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            terThroughputRepository.deleteCurrentDataByWharf(time,terId);
        }catch (ParseException e){
        }
    }

    @Override
    @Transactional
    public void deleteTerThroughputByDate(String date) {
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            terThroughputRepository.deleteTerThroughputByDate(time);
        }catch (ParseException e){
        }
    }
}
