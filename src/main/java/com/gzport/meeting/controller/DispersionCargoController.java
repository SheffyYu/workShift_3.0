package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.DispersionCargo;
import com.gzport.meeting.service.DispersionCargoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
