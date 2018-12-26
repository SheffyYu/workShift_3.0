package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.YearPlanThroughput;
import com.gzport.meeting.service.YearPlanThroughputService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/26.
 */
@RestController
@RequestMapping("/login/yearThrougthput")
public class YearPlanThroughputController {

    @Autowired
    YearPlanThroughputService yearPlanThroughputService;

    @PostMapping("/save")
    @ResponseBody
    public YearPlanThroughput save(@RequestBody YearPlanThroughput yearPlanThroughput){
        return yearPlanThroughputService.save(yearPlanThroughput);
    }

    @GetMapping("/findByCurrentYear")
    public YearPlanThroughput findByCurrentYear(){
        String year = new SimpleDateFormat("YYYY").format(new Date());
        return yearPlanThroughputService.findByYear(year);
    }

}
