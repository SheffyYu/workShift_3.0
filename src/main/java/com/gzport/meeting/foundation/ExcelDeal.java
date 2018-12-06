package com.gzport.meeting.foundation;

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

import static org.apache.poi.ss.usermodel.CellType.*;


/**
 * Created by zhangxiang on 2018/12/5.
 */
public class ExcelDeal {

    public static String getCellValue(HSSFCell  cell) {
        String value = null;
        if (cell != null) {
            switch (cell.getCellType()) {
                case FORMULA:
                    // cell.getCellFormula();
                    try {
                        value = String.valueOf(cell.getNumericCellValue());
                    } catch (IllegalStateException e) {
                        value = String.valueOf(cell.getRichStringCellValue());
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

}
