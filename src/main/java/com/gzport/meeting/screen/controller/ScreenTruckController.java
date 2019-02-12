package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.TruckStore;
import com.gzport.meeting.domain.vo.TruckVO;
import com.gzport.meeting.foundation.DateDeal;
import com.gzport.meeting.service.TruckStoreService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/2/1.
 */
@RestController
@RequestMapping("/screen/truck")
@Api(description = "车卡大屏接口")
public class ScreenTruckController {
    @Autowired
    TruckStoreService truckStoreService;

    @GetMapping("/getTruckByterCode")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "通过码头代码获取车卡数据")
    public List<TruckStore> findTruckNumberByTerCode(String terCode){
        String time =new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        List<TruckStore> truckStoreList=truckStoreService.findProByTerIdAndDate(terCode,DateDeal.getSpecifiedDayBefore(new Date()));
        return truckStoreList;
    }

    @GetMapping("/getTruckVoByterCode")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "通过码头代码按码头获取车卡饼图")
    public List<TruckVO> findTruckVoByTerCode(String terCode){
        String time =new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        List<TruckStore> truckStoreList=truckStoreService.findProByTerIdAndDate(terCode,DateDeal.getSpecifiedDayBefore(new Date()));
        if(truckStoreList.size()<1)
            return null;
        TruckStore truckStore=truckStoreList.get(0);
        List<TruckVO> truckVOList=new ArrayList<>();
        if(truckStore.getLoadiXg()!=0)
            truckVOList.add(new TruckVO("新港",truckStore.getLoadiXg()));
        if(truckStore.getLoadiXs()!=0)
            truckVOList.add(new TruckVO("新沙",truckStore.getLoadiXs()));
        if(truckStore.getLoadiXj()!=0)
            truckVOList.add(new TruckVO("西基",truckStore.getLoadiXj()));
        if(truckStore.getLoadiGct()!=0)
            truckVOList.add(new TruckVO("集司",truckStore.getLoadiGct()));
        if(truckStore.getLoadOutPort()!=0)
            truckVOList.add(new TruckVO("港外",truckStore.getLoadOutPort()));
        return truckVOList;
    }

    @GetMapping("/getTruckVoCargoByterCode")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "通过码头代码按货物获取车卡饼图")
    public List<TruckVO> findTruckVoCargoByTerCode(String terCode){
        String time =new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        List<TruckStore> truckStoreList=truckStoreService.findProByTerIdAndDate(terCode,DateDeal.getSpecifiedDayBefore(new Date()));
        if(truckStoreList.size()<1)
            return null;
        TruckStore truckStore=truckStoreList.get(0);
        List<TruckVO> truckVOList=new ArrayList<>();
       if(truckStore.getLoadoCoal()+truckStore.getLoadiCoal()!=0)
           truckVOList.add(new TruckVO("煤炭",truckStore.getLoadoCoal()+truckStore.getLoadiCoal()));
       if(truckStore.getLoadiOre()+truckStore.getLoadoOre()!=0)
           truckVOList.add(new TruckVO("矿石",truckStore.getLoadoCoal()+truckStore.getLoadiCoal()));
       if(truckStore.getLoadiOther()+truckStore.getLoadoOther()!=0)
           truckVOList.add(new TruckVO("其他",truckStore.getLoadiOther()+truckStore.getLoadoOther()));
        return truckVOList;
    }
}
