package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.Vessels;
import com.gzport.meeting.service.VesselsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by zhangxiang on 2019/1/30.
 */
@RestController
@RequestMapping("/login/vessles")
public class VesselsController  {

    @Autowired
    VesselsService vesselsService;

    @GetMapping("findByShipName")
    public Vessels findByName(String shipName){
        return vesselsService.find(shipName);
    }
}
