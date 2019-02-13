package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.VesselShipRealtim;
import com.gzport.meeting.domain.entity.Vessels;
import com.gzport.meeting.domain.vo.ShipRealtmVO;
import com.gzport.meeting.service.ShipRealtmService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by yushihui on 2019/2/12.
 */
@RestController
@RequestMapping("/screen/shipRealtm")
@Api(description = "船舶调度计划大屏接口")
public class ScreenShipRealtmController {
    @Autowired
    ShipRealtmService shipRealtmService;

    @GetMapping("/getShipRealtm")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "所有船舶调度计划大屏接口")
    public List<ShipRealtmVO> getAllData(String portcomp,String gmtState){//gmtstate 为0 则集装箱 为1 则散杂货
        List<ShipRealtmVO> srvoList=new ArrayList<>();
        List<VesselShipRealtim> vsrList=new ArrayList<>();
        String[] terCode=portcomp.split(",");
        for (int i=0;i<terCode.length;i++){
            vsrList.addAll(shipRealtmService.findAll(terCode[i]));
        }
//        Collections.sort(vsrList);
        for (VesselShipRealtim vsr : vsrList){
            if(vsr.getGmtname()!=null){
                if (gmtState.equals("0")){
                    if(vsr.getGmtname().equals("集装箱")){
                        srvoList.add(new ShipRealtmVO(vsr.getBertreal(),vsr.getVslname(),vsr.getVbt_comejob(),vsr.getGmtname(),vsr.getSumnumi(),vsr.getSumnume(),vsr.getVwkastarttm(),vsr.getBerthtime(),vsr.getLeavetime(),vsr.getPortcomp(),vsr.getEffect(),vsr.getWorkpace(),vsr.getIscash(),vsr.getVbt_pberthtm(),vsr.getVbt_pleavetm()));
                    }
                }else{
                    if (vsr.getGmtname().equals("集装箱") == false){
                        srvoList.add(new ShipRealtmVO(vsr.getBertreal(),vsr.getVslname(),vsr.getVbt_comejob(),vsr.getGmtname(),vsr.getSumnumi(),vsr.getSumnume(),vsr.getVwkastarttm(),vsr.getBerthtime(),vsr.getLeavetime(),vsr.getPortcomp(),vsr.getEffect(),vsr.getWorkpace(),vsr.getIscash(),vsr.getVbt_pberthtm(),vsr.getVbt_pleavetm()));
                    }
                }
            }

        }
        return srvoList;
    }
}
