package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.Throughput;
import com.gzport.meeting.domain.entity.ThroughputMonth;
import com.gzport.meeting.domain.entity.YearPlanThroughput;
import com.gzport.meeting.domain.vo.ThroughputMonthVO;
import com.gzport.meeting.service.ThroughputMonthService;
import com.gzport.meeting.service.ThroughputService;
import com.gzport.meeting.service.YearPlanThroughputService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/1/31.
 */
@RestController
@RequestMapping("/screen/throughput")
@Api(description = "大屏展示吞吐量接口")
public class ScreenThroughputController {

    @Autowired
    YearPlanThroughputService yearPlanThroughputService;

    @Autowired
    ThroughputService throughputService;

    @Autowired
    ThroughputMonthService throughputMonthService;

    @GetMapping("/getthroughputplan")
    @ApiOperation(value = "获取计划吞吐量")
    @CrossOrigin("http://datav.aliyun.com")
    public List<YearPlanThroughput> findDateBycurrentyear(){
        String year=new SimpleDateFormat("yyyy").format(new Date());
        List<YearPlanThroughput> yearPlanThroughputList=new ArrayList<>();
        YearPlanThroughput yearPlanThroughput=yearPlanThroughputService.findByYear(year);
        if(yearPlanThroughput!=null)
            yearPlanThroughputList.add(yearPlanThroughput);
        return yearPlanThroughputList;
    }

    @GetMapping("/getDailyThroughput")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "获取集团吞吐量")
    public List<Throughput> getThroughpot(){
        Sort sort=new Sort(Sort.Direction.DESC,"insTimestamp");
        Pageable page = new PageRequest(0,1,sort);
        Page<Throughput> throughputPage=throughputService.findThroughputforscreen(page);
        return throughputPage.getContent();
    }

    @GetMapping("/getMouthThroughput")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "按月统计集团吞吐量")
    public List<ThroughputMonthVO> getAllData(){
        ThroughputMonthVO throughputMonthVO=new ThroughputMonthVO();
        return throughputMonthVO.convertToThroughputVO(throughputMonthService.findAll());
    }

}
