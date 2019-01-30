package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Vessels;
import com.gzport.meeting.repository.VesselsRepository;
import com.gzport.meeting.service.VesselsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhangxiang on 2019/1/30.
 */

@Service
public class VesselsServiceImpl implements VesselsService {

    @Autowired
    VesselsRepository vesselsRepository;

    @Override
    public Vessels save(Vessels vessels) {
        return vesselsRepository.save(vessels);
    }

    @Override
    public Vessels find(String name) {
        return vesselsRepository.findByVslName(name);
    }
}
