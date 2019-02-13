package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.VesselShipRealtim;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by yushihui on 2019/2/12.
 */
public interface ShipRealtmRepository extends PagingAndSortingRepository<VesselShipRealtim,Long> {
    List<VesselShipRealtim> findAllByPortcomp(String portcomp);
}
