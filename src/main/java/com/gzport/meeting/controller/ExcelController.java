package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.foundation.BulkTerEnum;
import com.gzport.meeting.foundation.ExcelDeal;
import com.gzport.meeting.foundation.StringFundation;
import com.gzport.meeting.service.BulkStoreService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/5.
 */
@RestController
@RequestMapping("test/excel")
public class ExcelController {


    @Autowired
    BulkStoreService bulkStoreService;

    @PostMapping("/daily")
    public Iterable<BulkStore> delaExcel(@RequestParam("file")MultipartFile file){
        int startRow=7;
        int endRow=11;
        String date= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        List<BulkStore> bulkStoreList=bulkStoreService.getBulkByTime(date);
        DecimalFormat df = new DecimalFormat("#.0");
        String[][] data=new String[endRow-startRow+1][];
        Map<String,BulkStore> mapMap=new HashMap<>();
        if(bulkStoreList.size()>0) {
            for (BulkTerEnum e : BulkTerEnum.values()) {
                for(int i=0;i<bulkStoreList.size();i++){
                    if(bulkStoreList.get(i).getTerCode().equals(e.toString())){
                        mapMap.put(e.toString(),bulkStoreList.get(i));
                    }
                }
            }
        }
        try {
            InputStream inputStream=file.getInputStream();
            String fileType=file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1);
            if("xls".equals(fileType)){
                HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
                HSSFSheet hssfSheet=hssfWorkbook.getSheet("调度值班日报");
                for(int rowNum=startRow;rowNum<=endRow;rowNum++){
                    HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                    int minColIx = hssfRow.getFirstCellNum()+1;
                    int maxColIx = hssfRow.getLastCellNum();
                    data[rowNum-startRow]=new String[maxColIx];
                    for(int colIx=minColIx;colIx<maxColIx;colIx++){
                        HSSFCell cell = hssfRow.getCell(colIx);
                        if(cell!=null){
                            data[rowNum-startRow][colIx-minColIx]=new String();
                            data[rowNum-startRow][colIx-minColIx]= ExcelDeal.getCellValue(cell);
                        }
                    }
                }
                bulkStoreList=ExcelDeal.dailyDataDeal(data,mapMap);
            }
            if("xlsx".equals(fileType)){
                XSSFWorkbook xssfWorkbook = new XSSFWorkbook(inputStream);
                XSSFSheet xssfSheet=xssfWorkbook.getSheet("调度值班日报");
                for(int rowNum=startRow;rowNum<=endRow;rowNum++){
                    XSSFRow xhssfRow = xssfSheet.getRow(rowNum);
                    int minColIx = xhssfRow.getFirstCellNum()+1;
                    int maxColIx = xhssfRow.getLastCellNum();
                    data[rowNum-startRow]=new String[maxColIx];
                    for(int colIx=minColIx;colIx<maxColIx;colIx++){
                        XSSFCell cell = xhssfRow.getCell(colIx);
                        if(cell!=null){
                            data[rowNum-startRow][colIx-minColIx]=new String();
                            data[rowNum-startRow][colIx-minColIx]= ExcelDeal.getXCellValue(cell);
                        }
                    }
                }
                bulkStoreList=ExcelDeal.dailyDataDeal(data,mapMap);
            }
         } catch (IOException e) {
            e.printStackTrace();
        }
        return bulkStoreService.saveAll(bulkStoreList);
    }
}
