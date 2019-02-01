package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.IntfShip;
import com.gzport.meeting.repository.IntfShipRepository;
import com.gzport.meeting.service.IntfShipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/1/16.
 */
@Service
public class IntfShipServiceImpl implements IntfShipService {

    @Autowired
    IntfShipRepository intfShipRepository;

    @Override
    public List<IntfShip> findByDateAndStatue(Date date) {
        return intfShipRepository.findByDateAndShipStatue(date);
    }

    @Override
    public Page<IntfShip> findMaxDate(Pageable pageable) {
        return intfShipRepository.findAll(pageable);
    }
}
