package com.gzport.meeting.foundation;

import com.gzport.meeting.domain.entity.BulkStore;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.xssf.usermodel.XSSFCell;


import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Date;

import static org.apache.poi.ss.usermodel.CellType.*;


/**
 * Created by zhangxiang on 2018/12/5.
 */
public class ExcelDeal {

    DecimalFormat decimalFormat=new DecimalFormat(".0");

    public static String getCellValue(HSSFCell  cell) {
        String value = null;
        if (cell != null) {
            switch (cell.getCellType()) {
                case FORMULA:
                    // cell.getCellFormula();
                    try {
                        value = String.valueOf(cell.getNumericCellValue());
                    } catch (IllegalStateException e) {
                        //value = String.valueOf(cell.getRichStringCellValue());
                        value = "0";
                    }
                    break;
                case NUMERIC:
                    value = String.valueOf(cell.getNumericCellValue());
                    break;
                case STRING:
                    value = String.valueOf(cell.getRichStringCellValue());
                    break;
            }
        }
        return value;
    }

//    public static String getXCellValue(XSSFCell cell) {
//        String value = null;
//        if (cell != null) {
//            switch (cell.getCellType()) {
//                case 2:
//                    // cell.getCellFormula();
//                    try {
//                        value = String.valueOf(cell.getNumericCellValue());
//                    } catch (IllegalStateException e) {
//                        value = String.valueOf(cell.getRichStringCellValue());
//                    }
//                    break;
//                case 0:
//                    value = String.valueOf(cell.getNumericCellValue());
//                    break;
//                case 1:
//                    value = String.valueOf(cell.getRichStringCellValue());
//                    break;
//            }
//        }
//        return value;
//    }

    public static List<BulkStore> dailyDataDeal(String[][] data,Map<String,BulkStore> map,Date dataTime){
        List<BulkStore> bulkStoreList=new ArrayList<>();
        int sum=0;
        for(BulkTerEnum e:BulkTerEnum.values()){
            BulkStore bulkStore=new BulkStore();
            bulkStore.setInsTimeStamp(dataTime);
            if(map.get(e.toString())!=null)
                bulkStore=map.get(e.toString());
            bulkStore.setTerCode(e.toString());
            if(StringFundation.isNumber(data[0][sum]))
                bulkStore.setTotalStore(new BigDecimal(data[0][sum]).setScale(1,BigDecimal.ROUND_HALF_UP));
            if(StringFundation.isNumber(data[1][sum]))
                bulkStore.setOreStore(new BigDecimal(data[1][sum]).setScale(1,BigDecimal.ROUND_HALF_UP));
            if(StringFundation.isNumber(data[2][sum]))
                bulkStore.setCoalStore(new BigDecimal(data[2][sum]).setScale(1,BigDecimal.ROUND_HALF_UP));
            if(StringFundation.isNumber(data[3][sum]))
                bulkStore.setFoodStore(new BigDecimal(data[3][sum]).setScale(1,BigDecimal.ROUND_HALF_UP));
            if(StringFundation.isNumber(data[4][sum]))
                bulkStore.setSteelStore(new BigDecimal(data[4][sum]).setScale(1,BigDecimal.ROUND_HALF_UP));
            bulkStoreList.add(bulkStore);
            sum++;
        }
        return bulkStoreList;
    }

}
