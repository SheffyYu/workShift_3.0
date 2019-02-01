package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.AnchorageWork;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;

/**
 * Created by zhangxiang on 2019/1/31.
 */
@RestController
@RequestMapping("test/anchorage")
public class AnchorageWorkController {

//    @RequestMapping("/Excel")
//    public void dowloadExcel(){
//        AnchorageWork anchorageWork=new AnchorageWork();
//        anchorageWork.setVslNmae("新海星55");
//        anchorageWork.setVslNationality("中国");
//        anchorageWork.setVslType("散货船");
//        anchorageWork.setVslLoadton(Long.valueOf(40180));
//        File file_1=new File("D:\\file\\maodiwork.xls");
//    }
}
