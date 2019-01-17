package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.IntfShip;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/1/16.
 */
public interface IntfShipRepository extends PagingAndSortingRepository<IntfShip,Object> {

    @Modifying
    @Query(value = "SELECT t FROM IntfShip t  WHERE CREATE_DATE>=?1 AND CREATE_DATE-1<?1")
    List<IntfShip> findByDateAndShipStatue(Date date);

}
