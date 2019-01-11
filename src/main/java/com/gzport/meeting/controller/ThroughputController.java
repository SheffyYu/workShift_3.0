package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.Throughput;
import com.gzport.meeting.service.ThroughputService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/11.
 */
@RestController
@RequestMapping("/login/throughput")
public class ThroughputController {
    @Autowired
    ThroughputService throughputService;

    @PostMapping("/save")
    @ResponseBody
    public Throughput save(@RequestBody Throughput throughput){
        return throughputService.save(throughput);
    }

    @GetMapping("/getCurrentThroughput")
    public List<Throughput> getCurrentThroughput(@RequestParam String date){
        //String date= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        return throughputService.getByDate(date);
    }

}
