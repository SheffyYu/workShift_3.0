package com.gzport.meeting.controller;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.xml.transform.Result;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by zhangxiang on 2018/12/5.
 */
@RestController
@RequestMapping("test/excel")
public class ExcelController {

    @PostMapping("/daily")
    public Result delaExcel(@RequestParam("file")MultipartFile file){
        try {
            InputStream inputStream=file.getInputStream();
            String fileType=file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1);
            System.out.println("fileType"+fileType);
            if("xls".equals(fileType)){
                HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
                HSSFSheet hssfSheet=hssfWorkbook.getSheet("附表");
                HSSFRow hssfRow = hssfSheet.getRow(13);
                int minColIx = hssfRow.getFirstCellNum();
                int maxColIx = hssfRow.getLastCellNum();
                for(int colIx=minColIx;colIx<maxColIx;colIx++){
                    HSSFCell cell = hssfRow.getCell(colIx);
                    if(cell!=null){
                        System.out.println(cell.toString());
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
