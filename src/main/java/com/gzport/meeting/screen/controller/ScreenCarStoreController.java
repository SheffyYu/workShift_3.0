package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.CarStore;
import com.gzport.meeting.domain.vo.AliBrokenLineVO;
import com.gzport.meeting.service.CarStoreService;
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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by yushihui on 2019/2/14.
 */
@RestController
@RequestMapping("/screen/carStore")
@CrossOrigin("http://datav.aliyun.com")
@Api(description = "汽车库存接口")
public class ScreenCarStoreController {
    @Autowired
    CarStoreService carStoreService;

    @GetMapping("/getCarStore")
    @ApiOperation(value = "根据代码获取汽车库存")
    public List<CarStore> getCatStoreByTerCode(String terCode){
        Date date=new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<CarStore> carStore=new ArrayList<>();
        carStore=carStoreService.getBargeByTerIdAndTime(terCode,sdf.format(date));
        return carStore;
    }

    @GetMapping("/getLastFiveData")
    @ApiOperation(value = "根据码头代码获取码头近五日库存")
    public List<AliBrokenLineVO> getLastFiveDataByterCode(String terCode){
        Sort sort=new Sort(Sort.Direction.DESC,"insTimestamp");
        Pageable page = PageRequest.of(0,5,sort);
        List<CarStore> carStoreList = carStoreService.getLastFiveDataByTerCode(terCode,page);
        List<AliBrokenLineVO> aliBrokenLineVOS=new ArrayList<>();
        for(CarStore carStore : carStoreList){
            aliBrokenLineVOS.add(new AliBrokenLineVO(carStore.getCarNumber().toString(),carStore.getInsTimestamp()));
        }
        return aliBrokenLineVOS;
    }
}
