package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Barge;
import com.gzport.meeting.repository.BargeRepository;
import com.gzport.meeting.service.BargeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        String date=new SimpleDateFormat("yyyy-mm-dd").format(new Date());
        return bargeRepository.findCurrentDataByWharf(date,terId);
    }
}
