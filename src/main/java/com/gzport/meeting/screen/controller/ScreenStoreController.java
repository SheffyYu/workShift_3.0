package com.gzport.meeting.screen.controller;

import com.gzport.meeting.domain.entity.CntrStore;
import com.gzport.meeting.domain.vo.CntrDetatilVO;
import com.gzport.meeting.domain.vo.AliBrokenLineVO;
import com.gzport.meeting.service.CntrStoreService;
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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by zhangxiang on 2019/2/12.
 */
@RestController
@RequestMapping("/screen/cntrStore")
@CrossOrigin("http://datav.aliyun.com")
@Api(description = "集装箱库存大屏接口")
public class ScreenStoreController {

    @Autowired
    CntrStoreService cntrStoreService;

    @GetMapping("/getTotalCntrByterCode")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "根据码头代码获取码头集装箱库存")
    public String getCntrByTerCode(String terCode){
        List<CntrStore> cntrStoreList = new ArrayList<>();
        cntrStoreList=cntrStoreService.getCurrentCntrStroeByTerId(terCode);
        CntrStore cntrStore=new CntrStore();
        if(cntrStoreList.size()>0)
            cntrStore=cntrStoreList.get(0);
        return "[{\"cargoPer\":\""+cntrStore.getTotalCntr()+"\"}]";
    }

    @GetMapping("/getDetailCntr")
    @CrossOrigin("http://datav.aliyun.com")
    @ApiOperation(value = "根据码头代码获取码头集装箱库存详细信息")
    public List<CntrDetatilVO> getDetatilCntrStore(String terCode){
        List<CntrStore> cntrStoreList = new ArrayList<>();
        cntrStoreList=cntrStoreService.getCurrentCntrStroeByTerId(terCode);
        CntrStore cntrStore=new CntrStore();
        List<CntrDetatilVO> cntrDetatilVOList=new ArrayList<>();
        if(cntrStoreList.size()>0)
            cntrStore=cntrStoreList.get(0);
        if(cntrStore!=null){
            if(cntrStore.getLoadCntrE()!=0){
                CntrDetatilVO cntrDetatilVO=new CntrDetatilVO("重箱外贸",cntrStore.getLoadCntrE());
                cntrDetatilVOList.add(cntrDetatilVO);
            }
            if(cntrStore.getLoadCntrI()!=0){
                CntrDetatilVO cntrDetatilVO=new CntrDetatilVO("重箱内贸",cntrStore.getLoadCntrI());
                cntrDetatilVOList.add(cntrDetatilVO);
            }
            if(cntrStore.getEmpCntr()!=0){
                CntrDetatilVO cntrDetatilVO=new CntrDetatilVO("空箱",cntrStore.getEmpCntr());
                cntrDetatilVOList.add(cntrDetatilVO);
            }
        }
        return cntrDetatilVOList;
    }

    @GetMapping("/getLastFiveDay")
    @ApiOperation(value = "根据码头代码获取码头集装箱库存详细信息")
    public List<AliBrokenLineVO> getLastFiveDataByTerCode(String terCode){
        Sort sort=new Sort(Sort.Direction.DESC,"insTimestamp");
        Pageable page = PageRequest.of(0,5,sort);
        List<CntrStore> cntrStoreList=new ArrayList<>();
        List<AliBrokenLineVO> cntrStoreVOS=new ArrayList<>();
        cntrStoreList=cntrStoreService.getPaginDataByTerCode(terCode,page);
        Collections.reverse(cntrStoreList);
        for(CntrStore cntrStore : cntrStoreList){
            cntrStoreVOS.add(new AliBrokenLineVO(String.valueOf(cntrStore.getTotalCntr()),cntrStore.getInsTimestamp()));
        }
        return cntrStoreVOS;
    }
}
