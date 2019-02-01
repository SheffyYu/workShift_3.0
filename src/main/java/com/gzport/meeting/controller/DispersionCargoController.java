package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.DispersionCargo;
import com.gzport.meeting.service.DispersionCargoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.websocket.server.PathParam;

/**
 * Created by zhangxiang on 2018/12/3.
 */

@RestController
@RequestMapping("/login")
@Api(description = "疏运货类接口调用")
public class DispersionCargoController {

    @Autowired
    DispersionCargoService dispersionCargoService;

    @PostMapping("/saveCargo")
    @ApiOperation(value = "疏运货类存储")
    public DispersionCargo save(DispersionCargo dispersionCargo){
        return dispersionCargoService.save(dispersionCargo);
    }

    @DeleteMapping("/deleteCargo")
    @ApiOperation(value = "删除货物")
    public void delete(DispersionCargo dispersionCargo){
        dispersionCargoService.delete(dispersionCargo);
    }

    @GetMapping("/findByName/{name}")
    @ApiOperation(value = "通过货类名查找货物")
    public DispersionCargo findByName(@PathParam("name") String name){
        return dispersionCargoService.findByName(name);
    }
}
