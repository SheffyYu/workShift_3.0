package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.DailyTerdataLog;
import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.DispersionCargo;
import com.gzport.meeting.domain.vo.DispersionVO;
import com.gzport.meeting.service.DailyTerDataLogService;
import com.gzport.meeting.service.DispersionCargoService;
import com.gzport.meeting.service.DispersionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
@RestController
@RequestMapping("/login")
@Api(description = "疏运接口")
public class DispersionController {

    @Autowired
    DispersionService dispersionService;

    @Autowired
    DispersionCargoService dispersionCargoService;

    @Autowired
    DailyTerDataLogService dailyTerDataLogService;

    @PostMapping("/createDispersion")
    @ResponseBody
    @ApiOperation(value = "疏运数据保存")
    public Iterable<Dispersion> saveAll(@RequestBody List<DispersionVO> dispersionVOS){
        List<Dispersion> dispersions=new ArrayList();
        for(int i=0;i<dispersionVOS.size();i++){
            Dispersion dispersion=new Dispersion();
            dispersion.setCargoNumber(dispersionVOS.get(i).getWorkingNumber());
            dispersion.setCargoUnworkNumber(dispersionVOS.get(i).getUnWorkNumber());
            dispersion.setMechanicalNumber(dispersionVOS.get(i).getMechanicalNumber());
            dispersion.setTerCode(dispersionVOS.get(i).getTerCode());
            DispersionCargo dispersionCargo=dispersionCargoService.findByName(dispersionVOS.get(i).getCargoName());
            if(dispersionCargo==null){
                DispersionCargo newCargo=new DispersionCargo();
                newCargo.setCargoName(dispersionVOS.get(i).getCargoName());
                dispersion.setCargoCode(dispersionCargoService.save(newCargo).getCargoCodeId());
            }else{
                dispersion.setCargoCode(dispersionCargo.getCargoCodeId());
            }
            dispersions.add(dispersion);
        }
        return dispersionService.saveInterable(dispersions);
    }
}
