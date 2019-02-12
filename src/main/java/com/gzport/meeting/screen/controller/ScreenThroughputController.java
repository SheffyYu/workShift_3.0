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

import java.math.BigDecimal;
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
        Pageable page = PageRequest.of(0,1,sort);
        Page<Throughput> throughputPage=throughputService.findThroughputforscreen(page);
        List<Throughput> throughputList=throughputPage.getContent();
        if(throughputList.size()>0){
            Throughput throughput=throughputList.get(0);
            throughput.setThCargoPlan(throughput.getThCargoPlan().replace("(","").replace(")",""));
            throughput.setThCntrPlan(throughput.getThCntrPlan().replace("(","").replace(")",""));
            throughput.setThCntrTotal(throughput.getThCntrTotal().setScale(1,BigDecimal.ROUND_HALF_UP));
            throughput.setThCargoTotal(throughput.getThCargoTotal().setScale(1,BigDecimal.ROUND_HALF_UP));
            throughput.setCargoTotalPer(throughput.getCargoTotalPer().divide(BigDecimal.valueOf(100)));
            throughput.setCntrTotalPer(throughput.getCntrTotalPer().divide(BigDecimal.valueOf(100)));
        }
        return throughputPage.getContent();
    }

    @GetMapping("/getMonthper")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "获得每月吞吐量占比")
    public String getThroughpotPer(){
        Sort sort=new Sort(Sort.Direction.DESC,"insTimestamp");
        Pageable page = PageRequest.of(0,1,sort);
        Page<Throughput> throughputPage=throughputService.findThroughputforscreen(page);
        List<Throughput> throughputList=throughputPage.getContent();
        if(throughputList.size()>0){
            String cntrPer=throughputList.get(0).getCntrTotalPer().setScale(0,BigDecimal.ROUND_HALF_UP)+"%";
            String cargoPer=throughputList.get(0).getCargoTotalPer().setScale(0,BigDecimal.ROUND_HALF_UP)+"%";
            return "[{\"cargoPer\":\""+cargoPer+"\",\"cntrPer\":\"" + cntrPer + "\"}]";
        }
        return "";
    }

    @GetMapping("/getAccumuThroughput")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "获得每月吞吐量占比")
    public String accumuThroughput(){
        List<ThroughputMonth> throughputMonthList=throughputMonthService.findAll();
        BigDecimal cnrtThroughput= BigDecimal.valueOf(0);
        BigDecimal cargoThroughput= BigDecimal.valueOf(0);
        for(ThroughputMonth throughputMonth:throughputMonthList){
            cnrtThroughput=cnrtThroughput.add(throughputMonth.getThCntrTotal());
            cargoThroughput=cargoThroughput.add(throughputMonth.getThCargoTotal());
        }
        String year=new SimpleDateFormat("yyyy").format(new Date());
        YearPlanThroughput yearPlanThroughput=yearPlanThroughputService.findByYear(year);
        BigDecimal cntrPerNumber= BigDecimal.valueOf(0);
        BigDecimal cargoPerNumber= BigDecimal.valueOf(0);
        if(yearPlanThroughput.getCntrYearThroughput()!=0)
            cntrPerNumber=cnrtThroughput.divide(BigDecimal.valueOf(yearPlanThroughput.getCntrYearThroughput()),2,BigDecimal.ROUND_HALF_UP);
        if(yearPlanThroughput.getCargoYearThroughput()!=0)
            cargoPerNumber=cargoThroughput.divide(BigDecimal.valueOf(yearPlanThroughput.getCargoYearThroughput()),2,BigDecimal.ROUND_HALF_UP);
        String cargoPer=cargoPerNumber.
                multiply(BigDecimal.valueOf(100)).setScale(0,BigDecimal.ROUND_HALF_UP)+"%";
        String cntrPer=cntrPerNumber.
                multiply(BigDecimal.valueOf(100)).setScale(0,BigDecimal.ROUND_HALF_UP)+"%";
        return "[{\"cnrtThroughput\":\""+cnrtThroughput.setScale(1,BigDecimal.ROUND_HALF_UP)+"\",\"cargoThroughput\":\"" + cargoThroughput.setScale(1,BigDecimal.ROUND_HALF_UP)
                + "\",\"cargoPerNumber\":\"" + cargoPerNumber + "\",\"cntrPerNumber\":\"" + cntrPerNumber
                + "\",\"cargoPer\":\"" + cargoPer + "\",\"cntrPer\":\"" + cntrPer + "\"}]";
    }

    @GetMapping("/getMouthThroughput")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "按月统计集团吞吐量")
    public List<ThroughputMonthVO> getAllData(){
        ThroughputMonthVO throughputMonthVO=new ThroughputMonthVO();
        return throughputMonthVO.convertToThroughputVO(throughputMonthService.findAll());
    }

}
