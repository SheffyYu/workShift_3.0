package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.AnchorageWork;
import com.gzport.meeting.repository.AnchorageWorkRepository;
import com.gzport.meeting.service.AnchorageWorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by zhangxiang on 2019/1/31.
 */
@Service
public class AnchorageWorkServiceImpl implements AnchorageWorkService {

    @Autowired
    AnchorageWorkRepository anchorageWorkRepository;

    @Override
    public AnchorageWork save(AnchorageWork anchorageWork) {
        return anchorageWorkRepository.save(anchorageWork);
    }

    @Override
    public AnchorageWork findByShipName(String shipName) {
        return anchorageWorkRepository.findByVslNmae(shipName);
    }
}
