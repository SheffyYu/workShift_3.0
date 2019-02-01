package com.gzport.meeting.screen.controller;

import com.gzport.meeting.service.IntfShipService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by zhangxiang on 2019/2/1.
 */
@RestController
@RequestMapping("/screen/ship")
@Api(description = "船舶大屏接口")
public class ScreenShipController {
    @Autowired
    IntfShipService intfShipService;



}
