package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.vo.AliBrokenLineVO;
import com.gzport.meeting.service.BulkStoreService;
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
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by yushihui on 2019/2/14.
 */
@RestController
@RequestMapping("/screen/bulkStore")
@CrossOrigin("http://datav.aliyun.com")
@Api(description = "散货库存接口")
public class ScreenBulkStoreController {
    @Autowired
    BulkStoreService bulkStoreService;

    @GetMapping("/getBulkStore")
    @ApiOperation(value = "根据码头代码获取前一天的散货库存详细信息")
    public List<BulkStore> getBulkStoreByTerCode(String terCode){
        Calendar ca = Calendar.getInstance();//得到一个Calendar的实例
        ca.setTime(new Date()); //设置时间为当前时间
        ca.add(Calendar.DATE, -1); //年份减1
        Date date = ca.getTime(); //结果
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<BulkStore> bulkStore=new ArrayList<>();
        bulkStore=bulkStoreService.findBulkStoreByWharfAndTime(terCode,sdf.format(date));
        return bulkStore;
    }

    @GetMapping("/getLastFiveData")
    @ApiOperation(value = "根据码头代码获取近五日库存信息")
    public List<AliBrokenLineVO> getBulkStoreLastFiveData(String terCode){
        Sort sort=new Sort(Sort.Direction.DESC,"insTimeStamp");
        Pageable page = PageRequest.of(0,5,sort);
        List<BulkStore> bulkStoreList = bulkStoreService.getLastFiveDataByterCode(terCode,page);
        List<AliBrokenLineVO> aliBrokenLineVOList=new ArrayList<>();
        for(BulkStore bulkStore : bulkStoreList){
            aliBrokenLineVOList.add(new AliBrokenLineVO(bulkStore.getTotalStore().toString(),bulkStore.getInsTimeStamp()));
        }
        return aliBrokenLineVOList;
    }
}
