package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import com.gzport.meeting.service.BulkStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/10.
 */
@RequestMapping("/login")
@RestController
public class BulkStoreController  {

    @Autowired
    BulkStoreService bulkStoreService;

    @GetMapping("/getBulk/Daily")
    public List<BulkStoreVO> findCurrentStoreByDate(){
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return bulkStoreService.getBulkStoreVOByTime(time);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
}
