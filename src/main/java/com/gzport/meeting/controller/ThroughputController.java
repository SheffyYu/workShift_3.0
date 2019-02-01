package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.Throughput;
import com.gzport.meeting.service.ThroughputService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/11.
 */
@RestController
@RequestMapping("/login/throughput")
@Api(description = "吞吐量接口")
public class ThroughputController {
    @Autowired
    ThroughputService throughputService;

    @PostMapping("/save")
    @ResponseBody
    @ApiOperation(value = "保存吞吐量")
    public Throughput save(@RequestBody Throughput throughput){
        return throughputService.save(throughput);
    }

    @GetMapping("/getCurrentThroughput")
    @ApiOperation(value = "获得当天吞吐量")
    public List<Throughput> getCurrentThroughput(@RequestParam("date") String date){
        //String date= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return throughputService.getByDate(time);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

}
