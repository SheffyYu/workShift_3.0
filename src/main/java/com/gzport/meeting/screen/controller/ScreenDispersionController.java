package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.vo.ScreenDispersionVO;
import com.gzport.meeting.service.DispersionCargoService;
import com.gzport.meeting.service.DispersionService;
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
 * Created by zhangxiang on 2019/2/14.
 */
@RestController
@RequestMapping("/screen/dispersion")
@Api(description = "大屏疏运接口")
@CrossOrigin("http://datav.aliyun.com")
public class ScreenDispersionController {

    @Autowired
    DispersionService dispersionService;

    @Autowired
    DispersionCargoService dispersionCargoService;

    @GetMapping("/getDispersionNumber")
    @ApiOperation(value = "根据码头代码获取指定数量的数据")
    public List<ScreenDispersionVO> getDispersionforScreen(String terCode,Integer dataNumber){
        List<Dispersion> dispersionList = dispersionService.findCurrentDispersionByWharf(terCode);
        List<ScreenDispersionVO> screenDispersionVOList=new ArrayList<>();
        if(dataNumber==null)
            dataNumber=0;
        for(Dispersion dispersion:dispersionList){
            String cargoName=dispersionCargoService.findByCargoCodeId(dispersion.getCargoCode()).getCargoName();
            screenDispersionVOList.add(new ScreenDispersionVO("2",dispersion.getCargoNumber(),cargoName));
            screenDispersionVOList.add(new ScreenDispersionVO("1",dispersion.getCargoUnworkNumber(),cargoName));
        }
        if(screenDispersionVOList.size()>dataNumber*2)
            screenDispersionVOList=screenDispersionVOList.subList(0,dataNumber*2);
        int i=1;
        while(screenDispersionVOList.size()<dataNumber*2){
            screenDispersionVOList.add(new ScreenDispersionVO("2", (long) 0,"其他"+i));
            screenDispersionVOList.add(new ScreenDispersionVO("1",(long) 0,"其他"+i));
            i++;
        }
        Collections.reverse(screenDispersionVOList);
        return screenDispersionVOList;
    }

    @GetMapping("/getCargeDispersionNumber")
    @ApiOperation(value = "根据码头代码获取指定位置的数据")
    public List<ScreenDispersionVO> getCargoDispersionByOrder(String terCode,Integer position){
        List<Dispersion> dispersionList = dispersionService.findCurrentDispersionByWharf(terCode);
        List<ScreenDispersionVO> screenDispersionVOList=new ArrayList<>();
        if(position/2>dispersionList.size()){
            screenDispersionVOList.add(new ScreenDispersionVO("0", (long) 0,"其他"));
            return screenDispersionVOList;
        }else{
            if((position-1)%2==0)
                screenDispersionVOList.add(new ScreenDispersionVO("0",dispersionList.get((position-1)/2).getCargoNumber(),""));
            else
                screenDispersionVOList.add(new ScreenDispersionVO("0",dispersionList.get(((position-1)/2)+1).getCargoNumber(),""));
            return screenDispersionVOList;
        }
    }
}
