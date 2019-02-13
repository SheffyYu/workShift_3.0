package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.VesselShipRealtim;

import java.util.List;

/**
 * Created by yushihui on 2019/2/12.
 */
public interface ShipRealtmService {
    List<VesselShipRealtim> findAll(String portcomp);
}
