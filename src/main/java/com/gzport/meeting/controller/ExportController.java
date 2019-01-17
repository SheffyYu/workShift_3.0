package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.*;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import com.gzport.meeting.foundation.DateDeal;
import com.gzport.meeting.foundation.ExcelDeal;
import com.gzport.meeting.service.*;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/1/15.
 */
@RestController
@RequestMapping("/login/export")
public class ExportController {

    @Autowired
    BulkStoreService bulkStoreService;

    @Autowired
    ThroughputService throughputService;

    @Autowired
    IntfShipService intfShipService;

    @Autowired
    CntrStoreService cntrStoreService;

    @Autowired
    CarStoreService carStoreService;

    @Autowired
    TruckStoreService truckStoreService;

    @Autowired
    BargeService bargeService;

    @Autowired
    BargeXSService bargeXSService;

    @RequestMapping("/Excel")
    public void downLoadExcel(HttpServletResponse response,String time) throws IOException {
        Resource resource = new ClassPathResource("static/files/jiaoban.xls");
        File file_2 = resource.getFile();
        Date beforeDate=null;
        try {
            beforeDate=new SimpleDateFormat("yyyy-MM-dd").parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        InputStream inputStream=new FileInputStream(file_2);
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
        HSSFSheet hssfSheet=hssfWorkbook.getSheet("附表");
        if(hssfSheet!=null) {
            List<BulkStoreVO> bulkStoreVOS=bulkStoreService.getBulkStoreVOByTime(beforeDate);
            HSSFRow hssfRow=null;
            HSSFCell cell=null;
            hssfRow=hssfSheet.getRow(0);
            String excelDate=new SimpleDateFormat("yyyy年MM月dd日").format(beforeDate);
            HSSFCell Datecell = hssfRow.getCell(6);
            Datecell.setCellValue(excelDate);                                               //设置EXCEL日期
            List<Throughput> throughput=throughputService.getByDate(time);
            hssfRow=hssfSheet.getRow(1);
            HSSFCell cargoPlan=hssfRow.getCell(0);

            cargoPlan.setCellValue("货物吞吐量累计："+throughput.get(0).getThCargoPlan());
            cell=hssfRow.getCell(3);
            cell.setCellValue("集装箱吞吐量累计： "+throughput.get(0).getThCntrPlan());
            hssfRow=hssfSheet.getRow(2);                //第三行设置
            cell=hssfRow.getCell(0);
            cell.setCellValue(throughput.get(0).getThCargoTotal().setScale(1, BigDecimal.ROUND_HALF_UP)+"");              //设置货物每月累计
            cell=hssfRow.getCell(2);
            cell.setCellValue(throughput.get(0).getCargoTotalPer().setScale(1, BigDecimal.ROUND_HALF_UP)+"");         //设置货物百分比
            cell=hssfRow.getCell(3);
            cell.setCellValue(throughput.get(0).getThCntrTotal().setScale(1, BigDecimal.ROUND_HALF_UP)+"");        //设置集装箱累计
            cell=hssfRow.getCell(5);
            cell.setCellValue(throughput.get(0).getCntrTotalPer().setScale(1, BigDecimal.ROUND_HALF_UP)+"");        //设置集装箱累计
            cell=hssfRow.getCell(6);
            cell.setCellValue(throughput.get(0).getDailyTotal().setScale(1, BigDecimal.ROUND_HALF_UP)+
                    "("+throughput.get(0).getThrouthputNTC().setScale(1, BigDecimal.ROUND_HALF_UP)+
                    "+"+throughput.get(0).getThroughputGOCT().setScale(1, BigDecimal.ROUND_HALF_UP)+
                    "+"+throughput.get(0).getThroughputNICT().setScale(1, BigDecimal.ROUND_HALF_UP)+")");          //设置南沙集装箱吞吐量
            List<IntfShip> intfShipList=intfShipService.findByDateAndStatue(beforeDate);
            IntfShip intfShip = intfShipList.get(0).getShipStatue().equals("1")?intfShipList.get(0):intfShipList.get(1);
            System.out.println(intfShipList.size());
            //第六行设置
            hssfRow=hssfSheet.getRow(5);
            cell=hssfRow.getCell(0);
            cell.setCellValue(intfShip.getShipNumber());        //总艘数
            cell=hssfRow.getCell(2);
            cell.setCellValue(intfShip.getTradeNumber());       //外贸艘数
            cell=hssfRow.getCell(4);
            cell.setCellValue(intfShip.getWorkNumber());       //作业艘数
            IntfShip preintfShip = intfShipList.get(0).getShipStatue().equals("2")?intfShipList.get(0):intfShipList.get(1);
            cell=hssfRow.getCell(6);
            cell.setCellValue(preintfShip.getShipNumber());       //预报大船数
            //库存设置
            int startRow=8;     //值班调度日报标签吞吐量开始位置
            int endRow=12;      //结束位置
            for (int rowNum = startRow; rowNum <= endRow; rowNum++) {
                switch (rowNum){
                    case 8:
                        hssfRow = hssfSheet.getRow(rowNum);
                        for(int i=1;i<=6;i++){
                            cell = hssfRow.getCell(i);
                            cell.setCellValue(bulkStoreVOS.get(i-1).getTotalStore()!=null?bulkStoreVOS.get(i-1).getTotalStore().toString():null);
                        }
                        break;
                    case 9:
                        hssfRow = hssfSheet.getRow(rowNum);
                        for(int i=1;i<=6;i++){
                            cell = hssfRow.getCell(i);
                            cell.setCellValue(bulkStoreVOS.get(i-1).getOreStore()!=null?bulkStoreVOS.get(i-1).getOreStore().toString():null);
                        }
                        break;
                    case 10:
                        hssfRow = hssfSheet.getRow(rowNum);
                        for(int i=1;i<=6;i++){
                            cell = hssfRow.getCell(i);
                            cell.setCellValue(bulkStoreVOS.get(i-1).getCoalStore()!=null?bulkStoreVOS.get(i-1).getCoalStore().toString():null);
                        }
                        break;
                    case 11:
                        hssfRow = hssfSheet.getRow(rowNum);
                        for(int i=1;i<=6;i++){
                            cell = hssfRow.getCell(i);
                            cell.setCellValue(bulkStoreVOS.get(i-1).getFoodStore()!=null?bulkStoreVOS.get(i-1).getFoodStore().toString():null);
                        }
                        break;
                    case 12:
                        hssfRow = hssfSheet.getRow(rowNum);
                        for(int i=1;i<=6;i++){
                            cell = hssfRow.getCell(i);
                            cell.setCellValue(bulkStoreVOS.get(i-1).getSteelStore()!=null?bulkStoreVOS.get(i-1).getSteelStore().toString():null);
                        }
                        break;
                }
            }

            //第13行重箱堆存设置
            List<CntrStore> cntrStoreList=cntrStoreService.getCntrSotreByDate(beforeDate);
            for(int i=0;i<cntrStoreList.size();i++){
                CntrStore cntrStore=cntrStoreList.get(i);
                switch (cntrStore.getTerCode()){
                    case "NCT":
                        hssfRow=hssfSheet.getRow(13);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue("重箱堆存量 内贸:"+String.format("%5d",cntrStore.getLoadCntrI())+" T;外贸:"+String.format("%5d",cntrStore.getLoadCntrE())+" T;空箱堆存量:"+String.format("%5d",cntrStore.getEmpCntr())+" T;总计:"+String.format("%5d",cntrStore.getTotalCntr())+" T");
                        break;
                    case "GOCT":
                        hssfRow=hssfSheet.getRow(14);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue("重箱堆存量 内贸:"+String.format("%5d",cntrStore.getLoadCntrI())+" T;外贸:"+String.format("%5d",cntrStore.getLoadCntrE())+" T;空箱堆存量:"+String.format("%5d",cntrStore.getEmpCntr())+" T;总计:"+String.format("%5d",cntrStore.getTotalCntr())+" T");
                        break;
                    case "NICT":
                        hssfRow=hssfSheet.getRow(15);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue("重箱堆存量 内贸:"+String.format("%5d",cntrStore.getLoadCntrI())+" T;外贸:"+String.format("%5d",cntrStore.getLoadCntrE())+" T;空箱堆存量:"+String.format("%5d",cntrStore.getEmpCntr())+" T;总计:"+String.format("%5d",cntrStore.getTotalCntr())+" T");
                        break;
                    case "GCT":
                        hssfRow=hssfSheet.getRow(16);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue("重箱堆存量 内贸:"+String.format("%5d",cntrStore.getLoadCntrI())+" T;外贸:"+String.format("%5d",cntrStore.getLoadCntrE())+" T;空箱堆存量:"+String.format("%5d",cntrStore.getEmpCntr())+" T;总计:"+String.format("%5d",cntrStore.getTotalCntr())+" T");
                        break;
                }
            }

            //汽车库存设置
            List<CarStore> carStoreList=carStoreService.getBargeByTerIdAndTime("XS",new SimpleDateFormat("yyyy-MM-dd").format(beforeDate));
            if(carStoreList!=null) {
                hssfRow = hssfSheet.getRow(13);
                cell = hssfRow.getCell(7);
                cell.setCellValue(String.format("%4d", carStoreList.get(0).getCarNumber()) + "  辆");
            }
            carStoreList = carStoreService.getBargeByTerIdAndTime("NAT", new SimpleDateFormat("yyyy-MM-dd").format(beforeDate));
            if(carStoreList!=null) {
                hssfRow = hssfSheet.getRow(15);
                cell = hssfRow.getCell(7);
                cell.setCellValue(String.format("%4d", carStoreList.get(0).getCarNumber()) + "  辆");
            }

            //车卡设置
            List<TruckStore> truckStoreList=truckStoreService.findProByTerIdAndTime("TRAIN", new SimpleDateFormat("yyyy-MM-dd").format(beforeDate));
            if(truckStoreList.size()>0){
                TruckStore truckStore=truckStoreList.get(0);
                hssfRow = hssfSheet.getRow(20);
                cell = hssfRow.getCell(1);
                cell.setCellValue("港内:"+truckStore.getLoadInport());
                cell = hssfRow.getCell(3);
                cell.setCellValue("新港:"+truckStore.getLoadiXg()+" 西基:"+truckStore.getLoadiXj()+" 集司:"+truckStore.getLoadiGct()+" 新沙:"+truckStore.getLoadiXs());
                hssfRow = hssfSheet.getRow(21);
                cell = hssfRow.getCell(3);
                cell.setCellValue("煤炭:"+truckStore.getLoadiCoal()+" 矿石:"+truckStore.getLoadiOre()+" 其他:"+truckStore.getLoadiOther());
                cell = hssfRow.getCell(0);
                cell.setCellValue(truckStore.getTotalLoad());
                hssfRow = hssfSheet.getRow(22);
                cell = hssfRow.getCell(1);
                cell.setCellValue("港外:"+truckStore.getLoadOutPort());
                cell = hssfRow.getCell(2);
                cell.setCellValue("煤:"+truckStore.getLoadoCoal()+"  矿:"+truckStore.getLoadoOre());
                hssfRow = hssfSheet.getRow(20);
                cell = hssfRow.getCell(6);
                cell.setCellValue("卸车:"+truckStore.getUnloadTruck());
                cell = hssfRow.getCell(8);
                cell.setCellValue("待卸车:"+truckStore.getWaitUnload());
            }

            hssfSheet=hssfWorkbook.getSheet("码头驳船");
            if(hssfSheet!=null){
                //驳船设置
                List<Barge> bargeList=bargeService.getBargeByDate(beforeDate);
                for(int i=0;i<bargeList.size();i++){
                    Barge barge=bargeList.get(i);
                    switch (barge.getTerCode()){
                        case "NCT":
                            hssfRow = hssfSheet.getRow(4);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(barge.getShipNumber());
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(barge.getWorkingNumber());
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(barge.getUnWorkNumber());
                            break;
                        case "GOCT":
                            hssfRow = hssfSheet.getRow(6);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(barge.getShipNumber());
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(barge.getWorkingNumber());
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(barge.getUnWorkNumber());
                            break;
                        case "NICT":
                            hssfRow = hssfSheet.getRow(8);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(barge.getShipNumber());
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(barge.getWorkingNumber());
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(barge.getUnWorkNumber());
                            break;
                        case "GCT":
                            hssfRow = hssfSheet.getRow(10);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(barge.getShipNumber());
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(barge.getWorkingNumber());
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(barge.getUnWorkNumber());
                            break;
                        case "HP":
                            hssfRow = hssfSheet.getRow(15);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(barge.getShipNumber());
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(barge.getWorkingNumber());
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(barge.getUnWorkNumber());
                            break;
                    }
                }
            }
            List<BargeXS> bargeXSList=bargeXSService.getBargeByDate(beforeDate);
            if(bargeXSList.size()>0){
                for(int i=0;i<bargeXSList.size();i++){
                    BargeXS bargeXS=bargeXSList.get(i);
                    switch (bargeXS.getWorkType()){
                        case "驳船":
                            hssfRow = hssfSheet.getRow(12);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(bargeXS.getTotalNumber());
                            cell=hssfRow.getCell(2);
                            cell.setCellValue(bargeXS.getShuttlebusNumber());
                            cell=hssfRow.getCell(4);
                            cell.setCellValue(bargeXS.getShenzhenNumber());
                            cell=hssfRow.getCell(5);
                            cell.setCellValue(bargeXS.getItNumber());
                            cell=hssfRow.getCell(6);
                            cell.setCellValue(bargeXS.getEtNumber());
                            break;
                        case "作业线":
                            hssfRow = hssfSheet.getRow(13);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(bargeXS.getTotalNumber());
                            cell=hssfRow.getCell(2);
                            cell.setCellValue(bargeXS.getShuttlebusNumber());
                            cell=hssfRow.getCell(4);
                            cell.setCellValue(bargeXS.getShenzhenNumber());
                            cell=hssfRow.getCell(5);
                            cell.setCellValue(bargeXS.getItNumber());
                            cell=hssfRow.getCell(6);
                            cell.setCellValue(bargeXS.getEtNumber());
                            break;
                    }
                }
            }
            OutputStream os=new FileOutputStream(file_2);
            hssfWorkbook.write(os);
        }
        String fileName = new String("交接班记录表.xls".getBytes("GBK"), "ISO-8859-1");
        if (file_2.length() > 0) {
            response.setContentType("application/force-download");
            response.setHeader("Content-disposition", "attachment; filename=" + fileName);
            byte[] buffer = new byte[1024];
            FileInputStream fis = null;
            BufferedInputStream bis = null;
            try {
                fis = new FileInputStream(file_2);
                bis = new BufferedInputStream(fis);
                OutputStream os2 = response.getOutputStream();
                int i = bis.read(buffer);
                while (i != -1) {
                    os2.write(buffer, 0, i);
                    i = bis.read(buffer);
                }
                System.out.println("success");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
