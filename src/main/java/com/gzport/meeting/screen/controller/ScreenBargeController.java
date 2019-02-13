package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.Barge;
import com.gzport.meeting.domain.vo.AliBrokenLineVO;
import com.gzport.meeting.domain.vo.BargeWorkVO;
import com.gzport.meeting.service.BargeService;
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

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhangxiang on 2019/2/12.
 */
@RestController
@RequestMapping("/screen/barge")
@Api(description = "大屏展示驳船接口")
public class ScreenBargeController {
    @Autowired
    BargeService bargeService;

    @GetMapping("/getBargeNumber")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "通过码头代码获取码头驳船数量")
    public String getBargeNumberByterCode(String terCode){
        List<Barge> bargeList=bargeService.getCurrentBargeByTerId(terCode);
        Barge barge=new Barge();
        if(bargeList.size()>0){
            barge=bargeList.get(0);
        }
        return "[{\"bargeNumber\":\""+barge.getShipNumber()+"\"}]";
    }

    @GetMapping("/getBargeWorkNumber")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "通过码头代码获取驳船作业与待作业信息")
    public List<BargeWorkVO> getBargeWorkinfoByTerCode(String terCode){
        List<Barge> bargeList=bargeService.getCurrentBargeByTerId(terCode);
        List<BargeWorkVO> bargeWorkVOList=new ArrayList<>();
        Barge barge=new Barge();
        if(bargeList.size()>0){
            barge=bargeList.get(0);
        }
        if(barge!=null){
            bargeWorkVOList.add(new BargeWorkVO("作业",barge.getWorkingNumber()));
            bargeWorkVOList.add(new BargeWorkVO("待作业",barge.getUnWorkNumber()));
        }
        return bargeWorkVOList;
    }

    @GetMapping("/getLastFiveData")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "通过码头代码获取近五日驳船数据")
    public List<AliBrokenLineVO> getLastFiveData(String terCode){
        Sort sort=new Sort(Sort.Direction.DESC,"insTimestamp");
        Pageable page = PageRequest.of(0,5,sort);
        List<Barge> bargeList=bargeService.getLastFiveDataByTerCode(terCode,page);
        List<AliBrokenLineVO> aliBrokenLineVOS=new ArrayList<>();
        for(Barge barge:bargeList){
            aliBrokenLineVOS.add(new AliBrokenLineVO(barge.getShipNumber().toString(),barge.getInsTimestamp()));
        }
        return aliBrokenLineVOS;
    }
}
