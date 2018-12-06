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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        String reg = "^[0-9]+(.[0-9]+)?$";
        int startRow=7;
        int endRow=11;
        List<BulkStore> bulkStoreList=new ArrayList<>();
        DecimalFormat df = new DecimalFormat("#.0");
        String[][] data=new String[endRow-startRow+1][];
        Map<String,BulkStore> mapMap=new HashMap<>();
        for(BulkTerEnum e:BulkTerEnum.values()){
            mapMap.put(e.toString(),new BulkStore());
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
                int sum=0;
                for(BulkTerEnum e:BulkTerEnum.values()){
                    BulkStore bulkStore=mapMap.get(e.toString());
                    bulkStore.setTerCode(e.toString());
                    if(StringFundation.isNumber(data[0][sum]))
                        bulkStore.setTotalStore(Long.parseLong(data[0][sum]));
                    if(StringFundation.isNumber(data[1][sum]))
                        bulkStore.setOreStore(Long.parseLong(data[1][sum]));
                    if(StringFundation.isNumber(data[2][sum]))
                        bulkStore.setCoalStore(Long.parseLong(data[2][sum]));
                    if(StringFundation.isNumber(data[3][sum]))
                        bulkStore.setFoodStore(Long.parseLong(data[3][sum]));
                    if(StringFundation.isNumber(data[4][sum]))
                        bulkStore.setSteelStore(Long.parseLong(data[4][sum]));
                    bulkStoreList.add(bulkStore);
                    sum++;
                }
            }
//            if("xlsx".equals(fileType)){
//                XSSFWorkbook xssfWorkbook = new XSSFWorkbook(inputStream);
//                XSSFSheet xssfSheet=xssfWorkbook.getSheet("调度值班日报");
//                for(int rowNum=startRow;rowNum<=endRow;rowNum++){
//                    XSSFRow xhssfRow = xssfSheet.getRow(rowNum);
//                    int minColIx = xhssfRow.getFirstCellNum()+1;
//                    int maxColIx = xhssfRow.getLastCellNum();
//                    data[rowNum-startRow]=new String[maxColIx];
//                    for(int colIx=minColIx;colIx<maxColIx;colIx++){
//                        XSSFCell cell = xhssfRow.getCell(colIx);
//                        if(cell!=null){
//                            data[rowNum-startRow][colIx-minColIx]=new String();
//                            data[rowNum-startRow][colIx-minColIx]= ExcelDeal.getXCellValue(cell);
//                        }
//                    }
//                }
//                int sum=0;
//                for(BulkTerEnum e:BulkTerEnum.values()){
//                    BulkStore bulkStore=mapMap.get(e.toString());
//                    bulkStore.setTerCode(e.toString());
//                    if(StringFundation.isNumber(data[0][sum]))
//                        bulkStore.setTotalStore(Long.parseLong(data[0][sum]));
//                    if(StringFundation.isNumber(data[1][sum]))
//                        bulkStore.setOreStore(Long.parseLong(data[1][sum]));
//                    if(StringFundation.isNumber(data[2][sum]))
//                        bulkStore.setCoalStore(Long.parseLong(data[2][sum]));
//                    if(StringFundation.isNumber(data[3][sum]))
//                        bulkStore.setFoodStore(Long.parseLong(data[3][sum]));
//                    if(StringFundation.isNumber(data[4][sum]))
//                        bulkStore.setSteelStore(Long.parseLong(data[4][sum]));
//                    bulkStoreList.add(bulkStore);
//                    sum++;
//                }
//            }
         } catch (IOException e) {
            e.printStackTrace();
        }

        return bulkStoreService.saveAll(bulkStoreList);
    }
}
