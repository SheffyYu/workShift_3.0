package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.IntfShip;
import org.springframework.data.domain.Sort;

import java.util.List;
import java.util.Date;
/**
 * Created by zhangxiang on 2019/1/16.
 */
public interface IntfShipService {
    List<IntfShip> findByDateAndStatue(Date date);
}
