package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.VesselShipRealtim;
import com.gzport.meeting.repository.ShipRealtmRepository;
import com.gzport.meeting.service.ShipRealtmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by yushihui on 2019/2/12.
 */
@Service
public class shipRealtmServiceImpl implements ShipRealtmService {
    @Autowired
    ShipRealtmRepository shipRealtmRepository;

    @Override
    public List<VesselShipRealtim> findAll(String portcomp) {
    return shipRealtmRepository.findAllByPortcomp(portcomp);
}

}
