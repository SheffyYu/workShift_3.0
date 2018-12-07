package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.repository.DispersionRepository;
import com.gzport.meeting.service.DispersionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
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
        return dispersionRepository.findCurrentDataByWharf(date,terId);
    }

    @Override
    public Iterable<Dispersion> saveInterable(Iterable<Dispersion> dispersions) {
        return dispersionRepository.saveAll(dispersions);
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        dispersionRepository.deleteCurrentDataByWharf(date,terId);
    }


}
