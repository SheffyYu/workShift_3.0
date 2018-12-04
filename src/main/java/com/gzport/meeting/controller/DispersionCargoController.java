package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.DispersionCargo;
import com.gzport.meeting.service.DispersionCargoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.websocket.server.PathParam;

/**
 * Created by zhangxiang on 2018/12/3.
 */

@RestController
@RequestMapping("/login")
public class DispersionCargoController {

    @Autowired
    DispersionCargoService dispersionCargoService;

    @PostMapping("/saveCargo")
    public DispersionCargo save(DispersionCargo dispersionCargo){
        return dispersionCargoService.save(dispersionCargo);
    }

    @DeleteMapping("/deleteCargo")
    public void delete(DispersionCargo dispersionCargo){
        dispersionCargoService.delete(dispersionCargo);
    }

    @GetMapping("/findByName/{name}")
    public DispersionCargo findByName(@PathParam("name") String name){
        return dispersionCargoService.findByName(name);
    }
}
