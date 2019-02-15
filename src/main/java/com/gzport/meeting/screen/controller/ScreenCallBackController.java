package com.gzport.meeting.screen.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by zhangxiang on 2019/2/15.
 */

@RestController
@RequestMapping("/screen/callback")
@Api(description = "大屏回调接口")
public class ScreenCallBackController {

    @GetMapping("/getId")
    @ApiOperation(value = "返回回调值")
    public String getIdfromScreen(String id){
        return "[{\"id\":\""+id+"\"}]";
    }
}
