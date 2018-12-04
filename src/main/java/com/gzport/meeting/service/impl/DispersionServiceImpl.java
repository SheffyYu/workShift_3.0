package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.repository.DispersionRepository;
import com.gzport.meeting.service.DispersionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public Dispersion findCurrentDispersionByWharf(String terId) {
        return null;
    }

    @Override
    public Iterable<Dispersion> saveInterable(Iterable<Dispersion> iterable) {
        return dispersionRepository.save(iterable);
    }
}
