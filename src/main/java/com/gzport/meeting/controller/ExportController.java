package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.*;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import com.gzport.meeting.domain.vo.DispersionVO;
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
import java.util.ArrayList;
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

    @Autowired
    DispersionCargoService dispersionCargoService;

    @Autowired
    DispersionService dispersionService;

    @Autowired
    ProductionLineService productionLineService;

    @Autowired
    AttendenceService attendenceService;

    @RequestMapping("/Excel")
    public void downLoadExcel(HttpServletResponse response,String time) throws IOException {
//        Resource resource = new ClassPathResource("static/files/jiaoban.xls");
//        File file_1=resource.getFile();
        File file_1=new File("D:\\file\\jiaoban2.xls");
        FileInputStream fis_1 = new FileInputStream(file_1);
        File file_2 = new File("temp.xls");
        FileOutputStream fos = new FileOutputStream(file_2);
        byte datas[] = new byte[1024*8];
        //创建长度
        int len = 0;
        //循环读取数据
        while((len = fis_1.read(datas))!=-1){
            fos.write(datas,0,len);
        }
        //3.释放资源
        fis_1.close();
        fos.close();
        Date date=null;
        try {
            date=new SimpleDateFormat("yyyy-MM-dd").parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        InputStream inputStream=new FileInputStream(file_2);
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
        HSSFSheet hssfSheet=hssfWorkbook.getSheet("附表");
        if(hssfSheet!=null) {
            HSSFRow hssfRow=null;
            HSSFCell cell=null;
            hssfRow=hssfSheet.getRow(0);
            String excelDate=new SimpleDateFormat("yyyy年MM月dd日").format(DateDeal.getSpecifiedDayBefore(date));
            HSSFCell Datecell = hssfRow.getCell(6);
            Datecell.setCellValue(excelDate);                                               //设置EXCEL日期
            List<Throughput> throughput=throughputService.getByDate(DateDeal.getSpecifiedDayBefore(date));
            if(throughput.size()>0) {
                hssfRow = hssfSheet.getRow(1);
                HSSFCell cargoPlan = hssfRow.getCell(0);
                cargoPlan.setCellValue("货物吞吐量累计：" + throughput.get(0).getThCargoPlan());
                cell = hssfRow.getCell(3);
                cell.setCellValue("集装箱吞吐量累计： " + throughput.get(0).getThCntrPlan());
                hssfRow = hssfSheet.getRow(2);                //第三行设置
                cell = hssfRow.getCell(0);
                cell.setCellValue(throughput.get(0).getThCargoTotal().setScale(1, BigDecimal.ROUND_HALF_UP) + "");              //设置货物每月累计
                cell = hssfRow.getCell(2);
                cell.setCellValue(throughput.get(0).getCargoTotalPer().setScale(1, BigDecimal.ROUND_HALF_UP) + "");         //设置货物百分比
                cell = hssfRow.getCell(3);
                cell.setCellValue(throughput.get(0).getThCntrTotal().setScale(1, BigDecimal.ROUND_HALF_UP) + "");        //设置集装箱累计
                cell = hssfRow.getCell(5);
                cell.setCellValue(throughput.get(0).getCntrTotalPer().setScale(1, BigDecimal.ROUND_HALF_UP) + "");        //设置集装箱累计
                cell = hssfRow.getCell(6);
                cell.setCellValue(throughput.get(0).getDailyTotal().setScale(1, BigDecimal.ROUND_HALF_UP) +
                        "(" + throughput.get(0).getThrouthputNTC().setScale(1, BigDecimal.ROUND_HALF_UP) +
                        "+" + throughput.get(0).getThroughputGOCT().setScale(1, BigDecimal.ROUND_HALF_UP) +
                        "+" + throughput.get(0).getThroughputNICT().setScale(1, BigDecimal.ROUND_HALF_UP) + ")");          //设置南沙集装箱吞吐量
            }
            //第六行设置
            List<IntfShip> intfShipList=intfShipService.findByDateAndStatue(DateDeal.getSpecifiedDayBefore(date));
            if(intfShipList!=null){
                for(int i=0;i<intfShipList.size();i++){
                    IntfShip intfShip=intfShipList.get(i);
                    switch (intfShip.getShipStatue()){
                        case "1":
                            hssfRow=hssfSheet.getRow(5);
                            cell=hssfRow.getCell(0);
                            cell.setCellValue(intfShip.getShipNumber());        //总艘数
                            cell=hssfRow.getCell(2);
                            cell.setCellValue(intfShip.getTradeNumber());       //外贸艘数
                            cell=hssfRow.getCell(4);
                            cell.setCellValue(intfShip.getWorkNumber());       //作业艘数
                            break;
                        case "2":
                            cell=hssfRow.getCell(6);
                            cell.setCellValue(intfShip.getShipNumber());       //预报大船数
                            break;
                    }
                }
            }

            List<BulkStoreVO> bulkStoreVOS=bulkStoreService.getBulkStoreVOByTime(DateDeal.getSpecifiedDayBefore(date));
            for(int i=0;i<bulkStoreVOS.size();i++){
                BulkStoreVO bulkStoreVO=bulkStoreVOS.get(i);
                switch (bulkStoreVO.getTerCode()){
                    case "HP":
                        hssfRow=hssfSheet.getRow(8);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue(bulkStoreVO.getTotalStore()!= null ? bulkStoreVO.getTotalStore().toString():"");
                        hssfRow=hssfSheet.getRow(9);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue(bulkStoreVO.getOreStore()!=null?bulkStoreVO.getOreStore().toString():"");
                        hssfRow=hssfSheet.getRow(10);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue(bulkStoreVO.getCoalStore()!=null?bulkStoreVO.getCoalStore().toString():"");
                        hssfRow=hssfSheet.getRow(11);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue(bulkStoreVO.getFoodStore()!=null?bulkStoreVO.getFoodStore().toString():"");
                        hssfRow=hssfSheet.getRow(12);
                        cell=hssfRow.getCell(1);
                        cell.setCellValue(bulkStoreVO.getSteelStore()!=null?bulkStoreVO.getSteelStore().toString():"");
                        break;
                    case "XG":
                        hssfRow=hssfSheet.getRow(8);
                        cell=hssfRow.getCell(2);
                        cell.setCellValue(bulkStoreVO.getTotalStore()!= null ? bulkStoreVO.getTotalStore().toString():"");
                        hssfRow=hssfSheet.getRow(9);
                        cell=hssfRow.getCell(2);
                        cell.setCellValue(bulkStoreVO.getOreStore()!=null?bulkStoreVO.getOreStore().toString():"");
                        hssfRow=hssfSheet.getRow(10);
                        cell=hssfRow.getCell(2);
                        cell.setCellValue(bulkStoreVO.getCoalStore()!=null?bulkStoreVO.getCoalStore().toString():"");
                        hssfRow=hssfSheet.getRow(11);
                        cell=hssfRow.getCell(2);
                        cell.setCellValue(bulkStoreVO.getFoodStore()!=null?bulkStoreVO.getFoodStore().toString():"");
                        hssfRow=hssfSheet.getRow(12);
                        cell=hssfRow.getCell(2);
                        cell.setCellValue(bulkStoreVO.getSteelStore()!=null?bulkStoreVO.getSteelStore().toString():"");
                        break;
                    case "XJ":
                        hssfRow=hssfSheet.getRow(8);
                        cell=hssfRow.getCell(3);
                        cell.setCellValue(bulkStoreVO.getTotalStore()!= null ? bulkStoreVO.getTotalStore().toString():"");
                        hssfRow=hssfSheet.getRow(9);
                        cell=hssfRow.getCell(3);
                        cell.setCellValue(bulkStoreVO.getOreStore()!=null?bulkStoreVO.getOreStore().toString():"");
                        hssfRow=hssfSheet.getRow(10);
                        cell=hssfRow.getCell(3);
                        cell.setCellValue(bulkStoreVO.getCoalStore()!=null?bulkStoreVO.getCoalStore().toString():"");
                        hssfRow=hssfSheet.getRow(11);
                        cell=hssfRow.getCell(3);
                        cell.setCellValue(bulkStoreVO.getFoodStore()!=null?bulkStoreVO.getFoodStore().toString():"");
                        hssfRow=hssfSheet.getRow(12);
                        cell=hssfRow.getCell(3);
                        cell.setCellValue(bulkStoreVO.getSteelStore()!=null?bulkStoreVO.getSteelStore().toString():"");
                        break;
                    case "XS":
                        hssfRow=hssfSheet.getRow(8);
                        cell=hssfRow.getCell(4);
                        cell.setCellValue(bulkStoreVO.getTotalStore()!= null ? bulkStoreVO.getTotalStore().toString():"");
                        hssfRow=hssfSheet.getRow(9);
                        cell=hssfRow.getCell(4);
                        cell.setCellValue(bulkStoreVO.getOreStore()!=null?bulkStoreVO.getOreStore().toString():"");
                        hssfRow=hssfSheet.getRow(10);
                        cell=hssfRow.getCell(4);
                        cell.setCellValue(bulkStoreVO.getCoalStore()!=null?bulkStoreVO.getCoalStore().toString():"");
                        hssfRow=hssfSheet.getRow(11);
                        cell=hssfRow.getCell(4);
                        cell.setCellValue(bulkStoreVO.getFoodStore()!=null?bulkStoreVO.getFoodStore().toString():"");
                        hssfRow=hssfSheet.getRow(12);
                        cell=hssfRow.getCell(4);
                        cell.setCellValue(bulkStoreVO.getSteelStore()!=null?bulkStoreVO.getSteelStore().toString():"");
                        break;
                    case "NGT":
                        hssfRow=hssfSheet.getRow(8);
                        cell=hssfRow.getCell(6);
                        cell.setCellValue(bulkStoreVO.getTotalStore()!= null ? bulkStoreVO.getTotalStore().toString():"");
                        hssfRow=hssfSheet.getRow(9);
                        cell=hssfRow.getCell(6);
                        cell.setCellValue(bulkStoreVO.getOreStore()!=null?bulkStoreVO.getOreStore().toString():"");
                        hssfRow=hssfSheet.getRow(10);
                        cell=hssfRow.getCell(6);
                        cell.setCellValue(bulkStoreVO.getCoalStore()!=null?bulkStoreVO.getCoalStore().toString():"");
                        hssfRow=hssfSheet.getRow(11);
                        cell=hssfRow.getCell(6);
                        cell.setCellValue(bulkStoreVO.getFoodStore()!=null?bulkStoreVO.getFoodStore().toString():"");
                        hssfRow=hssfSheet.getRow(12);
                        cell=hssfRow.getCell(6);
                        cell.setCellValue(bulkStoreVO.getSteelStore()!=null?bulkStoreVO.getSteelStore().toString():"");
                        break;
                }
            }
            //库存设置
//            int startRow=8;     //值班调度日报标签吞吐量开始位置
//            int endRow=12;      //结束位置
//            if(bulkStoreVOS.size()>0) {
//                for (int rowNum = startRow; rowNum <= endRow; rowNum++) {
//                    switch (rowNum) {
//                        case 8:
//                            hssfRow = hssfSheet.getRow(rowNum);
//                            for (int i = 1; i <= 6; i++) {
//                                cell = hssfRow.getCell(i);
//                                cell.setCellValue(bulkStoreVOS.get(i - 1).getTotalStore() != null ? bulkStoreVOS.get(i - 1).getTotalStore().toString() : null);
//                            }
//                            break;
//                        case 9:
//                            hssfRow = hssfSheet.getRow(rowNum);
//                            for (int i = 1; i <= 6; i++) {
//                                cell = hssfRow.getCell(i);
//                                cell.setCellValue(bulkStoreVOS.get(i - 1).getOreStore() != null ? bulkStoreVOS.get(i - 1).getOreStore().toString() : null);
//                            }
//                            break;
//                        case 10:
//                            hssfRow = hssfSheet.getRow(rowNum);
//                            for (int i = 1; i <= 6; i++) {
//                                cell = hssfRow.getCell(i);
//                                cell.setCellValue(bulkStoreVOS.get(i - 1).getCoalStore() != null ? bulkStoreVOS.get(i - 1).getCoalStore().toString() : null);
//                            }
//                            break;
//                        case 11:
//                            hssfRow = hssfSheet.getRow(rowNum);
//                            for (int i = 1; i <= 6; i++) {
//                                cell = hssfRow.getCell(i);
//                                cell.setCellValue(bulkStoreVOS.get(i - 1).getFoodStore() != null ? bulkStoreVOS.get(i - 1).getFoodStore().toString() : null);
//                            }
//                            break;
//                        case 12:
//                            hssfRow = hssfSheet.getRow(rowNum);
//                            for (int i = 1; i <= 6; i++) {
//                                cell = hssfRow.getCell(i);
//                                cell.setCellValue(bulkStoreVOS.get(i - 1).getSteelStore() != null ? bulkStoreVOS.get(i - 1).getSteelStore().toString() : null);
//                            }
//                            break;
//                    }
//                }
//            }

            //第13行重箱堆存设置
            List<CntrStore> cntrStoreList=cntrStoreService.getCntrSotreByDate(date);
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
            List<CarStore> carStoreList=carStoreService.getBargeByTerIdAndTime("XS",new SimpleDateFormat("yyyy-MM-dd").format(date));
            if(carStoreList.size()>0) {
                hssfRow = hssfSheet.getRow(13);
                cell = hssfRow.getCell(7);
                cell.setCellValue(String.format("%4d", carStoreList.get(0).getCarNumber()) + "  辆");
            }
            carStoreList = carStoreService.getBargeByTerIdAndTime("NAT", new SimpleDateFormat("yyyy-MM-dd").format(date));
            if(carStoreList.size()>0) {
                hssfRow = hssfSheet.getRow(15);
                cell = hssfRow.getCell(7);
                cell.setCellValue(String.format("%4d", carStoreList.get(0).getCarNumber()) + "  辆");
            }

            //黄埔车卡设置
            List<TruckStore> truckStoreListHP=truckStoreService.findProByTerIdAndDate("HP",date);
            System.out.println("黄埔装车 "+truckStoreListHP.size());
            if(truckStoreListHP.size()>0){
                TruckStore truckStoreHP=truckStoreListHP.get(0);
                hssfRow = hssfSheet.getRow(18);
                cell = hssfRow.getCell(1);
                cell.setCellValue(truckStoreHP.getTotalLoad());
                hssfRow = hssfSheet.getRow(18);
                cell = hssfRow.getCell(5);
                cell.setCellValue(truckStoreHP.getUnloadTruck());
                hssfRow = hssfSheet.getRow(18);
                cell = hssfRow.getCell(7);
                cell.setCellValue(truckStoreHP.getWaitUnload());
            }

            //车卡设置
            List<TruckStore> truckStoreList=truckStoreService.findProByTerIdAndTime("TRAIN", new SimpleDateFormat("yyyy-MM-dd").format(DateDeal.getSpecifiedDayBefore(date)));
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
                List<Barge> bargeList=bargeService.getBargeByDate(date);
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




            //驳船数据设置
            List<BargeXS> bargeXSList=bargeXSService.getBargeByDate(date);
            if(bargeXSList.size()>0){
                for(int i=0;i<bargeXSList.size();i++){
                    BargeXS bargeXS=bargeXSList.get(i);
                    switch (bargeXS.getWorkType()){
                        case "驳船":
                            hssfRow = hssfSheet.getRow(12);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(bargeXS.getTotalNumber()!=null?bargeXS.getTotalNumber().toString():"");
                            cell=hssfRow.getCell(2);
                            cell.setCellValue(bargeXS.getShuttlebusNumber()!=null?bargeXS.getShuttlebusNumber().toString():"");
                            cell=hssfRow.getCell(4);
                            cell.setCellValue(bargeXS.getShenzhenNumber()!=null?bargeXS.getShenzhenNumber().toString():"");
                            cell=hssfRow.getCell(5);
                            cell.setCellValue(bargeXS.getItNumber()!=null?bargeXS.getItNumber().toString():"");
                            cell=hssfRow.getCell(6);
                            cell.setCellValue(bargeXS.getEtNumber()!=null?bargeXS.getEtNumber().toString():"");
                            break;
                        case "作业线":
                            hssfRow = hssfSheet.getRow(13);
                            cell = hssfRow.getCell(0);
                            cell.setCellValue(bargeXS.getTotalNumber()!=null?bargeXS.getTotalNumber().toString():"");
                            cell=hssfRow.getCell(2);
                            cell.setCellValue(bargeXS.getShuttlebusNumber()!=null?bargeXS.getShuttlebusNumber().toString():"");
                            cell=hssfRow.getCell(4);
                            cell.setCellValue(bargeXS.getShenzhenNumber()!=null?bargeXS.getShenzhenNumber().toString():"");
                            cell=hssfRow.getCell(5);
                            cell.setCellValue(bargeXS.getItNumber()!=null?bargeXS.getItNumber().toString():"");
                            cell=hssfRow.getCell(6);
                            cell.setCellValue(bargeXS.getEtNumber()!=null?bargeXS.getEtNumber().toString():"");
                            break;
                    }
                }
            }
            List<Dispersion> dispersionList=dispersionService.findDispersionByDate(date);
            List<DispersionVO> dispersionVOS=new ArrayList();
            for(int i=0;i<dispersionList.size();i++){
                DispersionVO dispersionVO=new DispersionVO();
                dispersionVO.setTerCode(dispersionList.get(i).getTerCode());
                dispersionVO.setDispersionId(dispersionList.get(i).getDispersionId());
                dispersionVO.setCargoName(dispersionCargoService.findByCargoCodeId(dispersionList.get(i).getCargoCode()).getCargoName());
                dispersionVO.setMechanicalNumber(dispersionList.get(i).getMechanicalNumber());
                dispersionVO.setWorkingNumber(dispersionList.get(i).getCargoNumber());
                dispersionVO.setUnWorkNumber(dispersionList.get(i).getCargoUnworkNumber());
                dispersionVOS.add(dispersionVO);
            }
            if(dispersionVOS.size()>0){
                hssfRow = hssfSheet.getRow(6);
                cell = hssfRow.getCell(8);
                cell.setCellValue("");
                int xjsum=0;
                for(int i=0;i<dispersionVOS.size();i++){
                    DispersionVO dispersionVO=dispersionVOS.get(i);
                    switch (dispersionVO.getTerCode()){
                        case "XG":
                            switch (dispersionVO.getCargoName()){
                                case "粮食":
                                    hssfRow = hssfSheet.getRow(4);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "钢材":
                                    hssfRow = hssfSheet.getRow(5);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "煤炭":
                                    hssfRow = hssfSheet.getRow(6);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(cell.getStringCellValue()==null||cell.getStringCellValue().equals("")?dispersionVO.getWorkingNumber()+"":dispersionVO.getWorkingNumber()+"/"+cell.getStringCellValue());
                                    break;
                                case "矿石":
                                    hssfRow = hssfSheet.getRow(6);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(cell.getStringCellValue()==null||cell.getStringCellValue().equals("")?dispersionVO.getWorkingNumber()+"":cell.getStringCellValue()+"/"+dispersionVO.getWorkingNumber());
                                    break;
                                default:
                                    hssfRow = hssfSheet.getRow(6);
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getCargoName()+"  "+dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                            }
                            break;
                        case "NGT":
                            switch (dispersionVO.getCargoName()){
                                case "钢材":
                                    hssfRow = hssfSheet.getRow(8);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "粮食":
                                    hssfRow = hssfSheet.getRow(9);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "纸浆":
                                    hssfRow = hssfSheet.getRow(10);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "石膏":
                                    hssfRow = hssfSheet.getRow(11);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "石油焦":
                                    hssfRow = hssfSheet.getRow(12);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "水渣":
                                    hssfRow = hssfSheet.getRow(13);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                            }
                            break;
                        case "XJ":
                            switch (dispersionVO.getCargoName()){
                                case "驳船":
                                    xjsum+=dispersionVO.getWorkingNumber();
                                    hssfRow = hssfSheet.getRow(15);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    break;
                                case "煤驳":
                                    xjsum+=dispersionVO.getUnWorkNumber();
                                    hssfRow = hssfSheet.getRow(15);
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "火车":
                                    xjsum+=dispersionVO.getWorkingNumber();
                                    hssfRow = hssfSheet.getRow(16);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "汽车":
                                    xjsum+=dispersionVO.getWorkingNumber();
                                    hssfRow = hssfSheet.getRow(16);
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "黄电":
                                    xjsum+=dispersionVO.getWorkingNumber();
                                    hssfRow = hssfSheet.getRow(17);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "恒电":
                                    xjsum+=dispersionVO.getWorkingNumber();
                                    hssfRow = hssfSheet.getRow(17);
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                            }
                            hssfRow = hssfSheet.getRow(18);
                            cell = hssfRow.getCell(8);
                            cell.setCellValue(xjsum);
                            break;
                        case "HP":
                            switch (dispersionVO.getCargoName()){
                                case "钢材":
                                    hssfRow = hssfSheet.getRow(20);
                                    cell = hssfRow.getCell(1);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(5);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "饲料":
                                    hssfRow = hssfSheet.getRow(21);
                                    cell = hssfRow.getCell(1);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(5);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "纸浆":
                                    hssfRow = hssfSheet.getRow(22);
                                    cell = hssfRow.getCell(1);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    break;
                                case "石灰石":
                                    hssfRow = hssfSheet.getRow(23);
                                    cell = hssfRow.getCell(1);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(5);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "高粱":
                                    hssfRow = hssfSheet.getRow(22);
                                    cell = hssfRow.getCell(5);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                            }
                            break;
                        case "XS":
                            switch (dispersionVO.getCargoName()){
                                case "煤驳":
                                    hssfRow = hssfSheet.getRow(20);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber());
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getUnWorkNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "煤卡":
                                    hssfRow = hssfSheet.getRow(21);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "矿卡":
                                    hssfRow = hssfSheet.getRow(21);
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "汽车直提":
                                    hssfRow = hssfSheet.getRow(22);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                                case "汽车转港":
                                    hssfRow = hssfSheet.getRow(22);
                                    cell = hssfRow.getCell(11);
                                    cell.setCellValue(dispersionVO.getWorkingNumber()+" "+(dispersionVO.getMechanicalNumber()!=0?dispersionVO.getMechanicalNumber()+"#":""));
                                    break;
                            }
                            break;
                    }
                }
            }


            //作业线设置
            List<ProductionLine> productionLineList=productionLineService.findProByDate(date);
            if(productionLineList.size()>0){
                for(int i=0;i<productionLineList.size();i++){
                    ProductionLine productionLine=productionLineList.get(i);
                    switch (productionLine.getTerCode()){
                        case "NCT":
                            hssfRow = hssfSheet.getRow(25);
                            cell = hssfRow.getCell(1);
                            cell.setCellValue(productionLine.getTotalLine());
                            hssfRow = hssfSheet.getRow(27);
                            cell = hssfRow.getCell(1);
                            cell.setCellValue(productionLine.getShipLine());
                            hssfRow = hssfSheet.getRow(29);
                            cell = hssfRow.getCell(1);
                            cell.setCellValue(productionLine.getBargeLine());
                            break;
                        case "GOCT":
                            hssfRow = hssfSheet.getRow(25);
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(productionLine.getTotalLine());
                            hssfRow = hssfSheet.getRow(27);
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(productionLine.getShipLine());
                            hssfRow = hssfSheet.getRow(29);
                            cell = hssfRow.getCell(2);
                            cell.setCellValue(productionLine.getBargeLine());
                            break;
                        case "NICT":
                            hssfRow = hssfSheet.getRow(25);
                            cell = hssfRow.getCell(3);
                            cell.setCellValue(productionLine.getTotalLine());
                            hssfRow = hssfSheet.getRow(27);
                            cell = hssfRow.getCell(3);
                            cell.setCellValue(productionLine.getShipLine());
                            hssfRow = hssfSheet.getRow(29);
                            cell = hssfRow.getCell(3);
                            cell.setCellValue(productionLine.getBargeLine());
                            break;
                        case "GCT":
                            hssfRow = hssfSheet.getRow(25);
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(productionLine.getTotalLine());
                            hssfRow = hssfSheet.getRow(27);
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(productionLine.getShipLine());
                            hssfRow = hssfSheet.getRow(29);
                            cell = hssfRow.getCell(4);
                            cell.setCellValue(productionLine.getBargeLine());
                            break;
                        case "XS":
                            hssfRow = hssfSheet.getRow(25);
                            cell = hssfRow.getCell(5);
                            cell.setCellValue(productionLine.getTotalLine());
                            hssfRow = hssfSheet.getRow(27);
                            cell = hssfRow.getCell(5);
                            cell.setCellValue(productionLine.getShipLine());
                            hssfRow = hssfSheet.getRow(29);
                            cell = hssfRow.getCell(5);
                            cell.setCellValue(productionLine.getBargeLine());
                            break;
                        case "HP":
                            hssfRow = hssfSheet.getRow(25);
                            cell = hssfRow.getCell(6);
                            cell.setCellValue(productionLine.getTotalLine());
                            hssfRow = hssfSheet.getRow(27);
                            cell = hssfRow.getCell(6);
                            cell.setCellValue(productionLine.getShipLine());
                            hssfRow = hssfSheet.getRow(29);
                            cell = hssfRow.getCell(6);
                            cell.setCellValue(productionLine.getBargeLine());
                            break;
                    }
                }
            }

            //出勤人员设置
            List<Attendence> attendenceList=attendenceService.findAttendenceByDate(date);
            if(attendenceList.size()>0){
                for(int i=0;i<attendenceList.size();i++){
                    Attendence attendence=attendenceList.get(i);
                    switch (attendence.getTerCode()){
                        case "HP":
                            switch (attendence.getAttTime()){
                                case "0000-0730":
                                    hssfRow = hssfSheet.getRow(25);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(28);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                                case "0730-1530":
                                    hssfRow = hssfSheet.getRow(31);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(34);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                                case "1530-2400":
                                    hssfRow = hssfSheet.getRow(37);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(40);
                                    cell = hssfRow.getCell(8);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                            }
                            break;
                        case "NGT":
                            switch (attendence.getAttTime()){
                                case "0000-0730":
                                    hssfRow = hssfSheet.getRow(25);
                                    cell = hssfRow.getCell(10);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(28);
                                    cell = hssfRow.getCell(10);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                                case "0730-1530":
                                    hssfRow = hssfSheet.getRow(31);
                                    cell = hssfRow.getCell(10);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(34);
                                    cell = hssfRow.getCell(10);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                                case "1530-2400":
                                    hssfRow = hssfSheet.getRow(37);
                                    cell = hssfRow.getCell(10);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(40);
                                    cell = hssfRow.getCell(10);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                            }
                            break;
                        case "XG":
                            switch (attendence.getAttTime()){
                                case "0000-0730":
                                    hssfRow = hssfSheet.getRow(25);
                                    cell = hssfRow.getCell(9);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(28);
                                    cell = hssfRow.getCell(9);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                                case "0730-1530":
                                    hssfRow = hssfSheet.getRow(31);
                                    cell = hssfRow.getCell(9);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(34);
                                    cell = hssfRow.getCell(9);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                                case "1530-2400":
                                    hssfRow = hssfSheet.getRow(37);
                                    cell = hssfRow.getCell(9);
                                    cell.setCellValue(attendence.getWorkingStaff());
                                    hssfRow = hssfSheet.getRow(40);
                                    cell = hssfRow.getCell(9);
                                    cell.setCellValue(attendence.getWatiStaff());
                                    break;
                            }
                            break;
                    }
                }
            }

            OutputStream os=new FileOutputStream(file_2);
            hssfWorkbook.write(os);
        }
        String fileNameDate=new SimpleDateFormat("dd").format(DateDeal.getSpecifiedDayBefore(date))+"-"+new SimpleDateFormat("dd").format(date)+"交接班记录.xls";
        String fileName = new String(fileNameDate.getBytes("GBK"), "ISO-8859-1");
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
