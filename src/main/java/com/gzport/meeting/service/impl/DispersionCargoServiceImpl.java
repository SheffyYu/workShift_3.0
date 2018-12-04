package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.DispersionCargo;
import com.gzport.meeting.repository.DispersionCargoRepository;
import com.gzport.meeting.service.DispersionCargoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhangxiang on 2018/12/3.
 */

@Service
public class DispersionCargoServiceImpl implements DispersionCargoService {

    @Autowired
    DispersionCargoRepository dispersionCargoRepository;


    @Override
    public DispersionCargo save(DispersionCargo dispersionCargo) {
        return dispersionCargoRepository.save(dispersionCargo);
    }

    @Override
    public void delete(DispersionCargo dispersionCargo) {
         dispersionCargoRepository.delete(dispersionCargo);
    }

    @Override
    public DispersionCargo findByName(String name) {
        return dispersionCargoRepository.findByCargoName(name);
    }
}
