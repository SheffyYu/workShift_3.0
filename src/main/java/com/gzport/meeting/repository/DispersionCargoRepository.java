package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.DispersionCargo;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2018/12/3.
 */
public interface DispersionCargoRepository extends PagingAndSortingRepository<DispersionCargo,String> {

    DispersionCargo findByCargoName(String name);

}
