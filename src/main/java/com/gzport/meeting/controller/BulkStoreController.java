package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.entity.Throughput;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import com.gzport.meeting.service.BulkStoreService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/10.
 */
@RequestMapping("/login/bulkStore")
@RestController
@Api(value = "/login/bulkStore", description = "库存调用接口")
public class BulkStoreController  {

    @Autowired
    BulkStoreService bulkStoreService;

    @ApiOperation(value = "获得每日库存",notes = "获得每日库存")
    @GetMapping("/getDaily")
    public List<BulkStoreVO> findCurrentStoreByDate(@RequestParam("date") String date){
        //String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bulkStoreService.getBulkStoreVOByTime(time);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @PostMapping("/save")
    @ResponseBody
    @ApiOperation(value = "库存存储")
    public BulkStore save(@RequestBody BulkStore bulkStore){
        return  bulkStoreService.save(bulkStore);
    }
}
