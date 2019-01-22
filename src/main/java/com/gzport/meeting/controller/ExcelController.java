package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.entity.TerThroughput;
import com.gzport.meeting.domain.entity.Throughput;
import com.gzport.meeting.foundation.*;
import com.gzport.meeting.service.BulkStoreService;
import com.gzport.meeting.service.TerThroughputService;
import com.gzport.meeting.service.ThroughputService;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
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

    @Autowired
    ThroughputService throughputService;

    @Autowired
    TerThroughputService terThroughputService;


    @PostMapping("/daily")
    public Iterable<BulkStore> delaExcel(@RequestParam("file")MultipartFile file,@RequestParam("date")String date){
        //String date= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        List<BulkStore> bulkStoreList=bulkStoreService.getBulkByTime(date);
        Date dataTime= DateDeal.DateConvert(date);
        if(dataTime!=null&&dataTime.getTime()>new Date().getTime())
            return null;
        Auth auth = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        Map<String,BulkStore> mapMap=new HashMap<>();
        if(bulkStoreList.size()>0) {
            for (BulkTerEnum e : BulkTerEnum.values()) {
                for(int i=0;i<bulkStoreList.size();i++){
                    if(bulkStoreList.get(i).getTerCode()!=null&&bulkStoreList.get(i).getTerCode().equals(e.toString())){
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
                throughputService.deleteByDate(date);
                if(hssfSheet!=null) {
                    int startRow=7;     //值班调度日报标签吞吐量开始位置
                    int endRow=11;      //结束位置
                    String[][] data=new String[endRow-startRow+1][];        //数据保存
                    Throughput throughput = getThroughput(hssfSheet);
                    if (throughput != null) {
                        throughput.setInsAccount(auth.getAccount());
                        throughput.setUpdAccount(auth.getAccount());
                        throughput.setInsTimestamp(dataTime);
                        throughputService.save(throughput);
                    }
                    for (int rowNum = startRow; rowNum <= endRow; rowNum++) {
                        HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                        int minColIx = hssfRow.getFirstCellNum() + 1;
                        int maxColIx = hssfRow.getLastCellNum();
                        data[rowNum - startRow] = new String[maxColIx];
                        for (int colIx = minColIx; colIx < maxColIx; colIx++) {
                            HSSFCell cell = hssfRow.getCell(colIx);
                            if (cell != null) {
                                data[rowNum - startRow][colIx - minColIx] = new String();
                                data[rowNum - startRow][colIx - minColIx] = ExcelDeal.getCellValue(cell);
                            }
                        }
                    }
                    bulkStoreList = ExcelDeal.dailyDataDeal(data, mapMap,dataTime);
                }
                hssfSheet = hssfWorkbook.getSheet("吞吐量");
                if(hssfSheet!=null){
                    int terStart=27;            //码头吞吐量开始位置
                    int terEnd=29;              //码头吞吐量结束位置
                    int terWidth= 8;           //吞吐量标签港口数量
                    int terHight=terEnd-terStart+1;            //吞吐量标签数据高度
                    String[][] terthroughputData=new String[terHight][terWidth];
                    for(int rowNum=terStart;rowNum<=terEnd;rowNum++){
                        HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                        for (int j = 1; j <= 8; j++) {
                            HSSFCell cell = hssfRow.getCell(j*2-1);
                            if (cell != null) {
                                terthroughputData[rowNum - terStart][j - 1] = new String();
                                terthroughputData[rowNum - terStart][j - 1] = ExcelDeal.getCellValue(cell)==null?"0":ExcelDeal.getCellValue(cell);
                                //terthroughputData[rowNum - terStart][j - 1] = ExcelDeal.getCellValue(cell);
                            }
                        }
                    }
                    terThroughputService.deleteTerThroughputByDate(date);
                    List<TerThroughput> terThroughputList=new ArrayList<>();
                    int tag=0;
                    for (ThroughputTerEnum e : ThroughputTerEnum.values()) {
                        TerThroughput terThroughput=new TerThroughput();
                        terThroughput.setTerCode(e.toString());
                        terThroughput.setInsTimestamp(dataTime);
                        terThroughput.setMonthlyPlan(new BigDecimal(terthroughputData[0][tag]));
                        terThroughput.setMonthlyTotal(new BigDecimal(terthroughputData[1][tag]).setScale(0, RoundingMode.HALF_UP));
                        terThroughput.setMonthlyPer(new BigDecimal(terthroughputData[2][tag]));
                        terThroughput.setInsAccount(auth.getAccount());
                        terThroughput.setUpdAccount(auth.getAccount());
                        terThroughputList.add(terThroughput);
                        tag++;
                    }
                    terThroughputService.saveAll(terThroughputList);
                }
            }
         } catch (IOException e) {
            e.printStackTrace();
        }
        return bulkStoreService.saveAll(bulkStoreList);
    }


    public static Throughput getThroughput(HSSFSheet hssfSheet){
        Throughput throughput=new Throughput();
        throughput.setCargoTotalPer(new BigDecimal(getXSSFSheetData(hssfSheet,3,2)));
        throughput.setThCargoTotal(new BigDecimal(getXSSFSheetData(hssfSheet,3,0)));
        throughput.setThCntrTotal(new BigDecimal(getXSSFSheetData(hssfSheet,3,3)));
        throughput.setCntrTotalPer(new BigDecimal(getXSSFSheetData(hssfSheet,3,5)));
        throughput.setDailyTotal(new BigDecimal(getXSSFSheetData(hssfSheet,3,6)));
        throughput.setThrouthputNTC(new BigDecimal(getXSSFSheetData(hssfSheet,3,7)));
        throughput.setThroughputGOCT(new BigDecimal(getXSSFSheetData(hssfSheet,3,8)));
        throughput.setThroughputNICT(new BigDecimal(getXSSFSheetData(hssfSheet,3,9)));
        throughput.setThCargoPlan(getXSSFSheetData(hssfSheet,2,1));
        throughput.setThCntrPlan(getXSSFSheetData(hssfSheet,2,4));
        return throughput;
    }


    public static String getXSSFSheetData(HSSFSheet hssfSheet,int row,int col){
        HSSFRow hssfRow = hssfSheet.getRow(row);
        HSSFCell cell = hssfRow.getCell(col);
        return ExcelDeal.getCellValue(cell);
    }
}
