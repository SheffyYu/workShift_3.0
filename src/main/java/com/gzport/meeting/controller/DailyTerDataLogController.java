package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.DailyTerdataLog;
import com.gzport.meeting.service.DailyTerDataLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/28.
 */
@RestController
@RequestMapping("/login")
public class DailyTerDataLogController {
    @Autowired
    DailyTerDataLogService dailyTerDataLogService;

    @GetMapping("/getUnwirteTerCode")
    List<DailyTerdataLog> findByUnwriteTer(){
        return dailyTerDataLogService.findDataByStatus("0");
    }

}
