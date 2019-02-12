package com.gzport.meeting.screen.controller;

import com.alibaba.fastjson.JSONArray;
import com.gzport.meeting.domain.entity.Barge;
import com.gzport.meeting.domain.entity.BargeXS;
import com.gzport.meeting.domain.entity.IntfShip;
import com.gzport.meeting.repository.IntfShipRepository;
import com.gzport.meeting.service.BargeService;
import com.gzport.meeting.service.BargeXSService;
import com.gzport.meeting.service.IntfShipService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/2/1.
 */
@RestController
@RequestMapping("/screen/ship")
@Api(description = "船舶大屏接口")
public class ScreenShipController {
    @Autowired
    IntfShipService intfShipService;

    @Autowired
    BargeService bargeService;

    @Autowired
    BargeXSService bargeXSService;

    @Autowired
    IntfShipRepository intfShipRepository;

    @GetMapping("/getShipData")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "获取近5日大船与预报船数量")
    public List<IntfShip> getShipByMaxDate(){
        Sort sort=new Sort(Sort.Direction.DESC,"createDate");
        Pageable page = PageRequest.of(0,10,sort);
//        return intfShipRepository.findAll();
        return intfShipService.findMaxDate(page).getContent();
    }

    @GetMapping("/getBigShipNumber")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "获得大船数量")
    public List<IntfShip> getInportShipNumber(){
        List<IntfShip> intfShipList=intfShipService.findShipNumberByStatue("1");
        IntfShip intfShip=new IntfShip();
        if(intfShipList.size()>0){
            intfShip=intfShipList.get(0);
        }
        List<IntfShip> intfShips=new ArrayList<>();
        intfShips.add(intfShip);
        return intfShips;
    }

    @GetMapping("/getBargeNumber")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "获取驳船数量")
    public String getBargeNumber(){
        String time=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        Integer bargeNumber=0;
        try {
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(time);
            List<Barge> bargeList=bargeService.getBargeByDate(date);
            List<BargeXS> bargeXSList=bargeXSService.getBargeByDate(date);
            for(Barge b:bargeList){
                bargeNumber+=b.getShipNumber();
            }
            for(BargeXS bxs:bargeXSList){
                bargeNumber+=bxs.getTotalNumber();
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return "[{\"shipNumber\":\""+bargeNumber+"\"}]";
    }
}
