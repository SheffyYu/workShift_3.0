package com.gzport.meeting.controller;

import com.alibaba.fastjson.JSONObject;
import com.gzport.meeting.common.SaveResult;
import com.gzport.meeting.domain.dto.AuthInfo;
import com.gzport.meeting.domain.entity.*;
import com.gzport.meeting.domain.vo.DispersionVO;
import com.gzport.meeting.domain.vo.TerminalVO;
import com.gzport.meeting.foundation.DateDeal;
import com.gzport.meeting.server.WebSocketServer;
import com.gzport.meeting.service.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * Created by zhangxiang on 2018/12/4.
 */
@RestController
@RequestMapping("/login")
@Api(description = "码头数据提交接口")
public class TerminalsDateController {

    @Autowired
    DispersionCargoService dispersionCargoService;

    @Autowired
    DispersionService dispersionService;

    @Autowired
    BargeService bargeService;

    @Autowired
    BargeXSService bargeXSService;

    @Autowired
    CntrStoreService cntrStoreService;

    @Autowired
    ProductionLineService productionLineService;

    @Autowired
    TruckStoreService truckStoreService;

    @Autowired
    AuthService authService;

    @Autowired
    CarStoreService carStoreService;

    @Autowired
    DailyTerDataLogService dailyTerDataLogService;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    AttendenceService attendenceService;

    @Autowired
    BulkStoreService bulkStoreService;


    @PostMapping("/saveData")
    @ResponseBody
    @ApiOperation(value = "码头数据提交接口")
    public SaveResult saveDateFromTer(@RequestBody TerminalVO terminalVO){
        Auth user = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        System.out.println(terminalVO.getAttendenceList().size());
        user = authService.findByAccount(user.getAccount());
        Date dataTime=DateDeal.DateConvert(terminalVO.getDataTime());
        if(dataTime!=null&&dataTime.getTime()>new Date().getTime())
            return SaveResult.getInstance(SaveResult.REFUSE);
        Auth auth=new Auth();
        auth.setCompany(user.getCompany());
        auth.setAccount(user.getAccount());
        auth.setDescription(user.getDescription());
        auth.setName(user.getName());
        if(terminalVO.getTerCode()!=null&&!"".equals(terminalVO.getTerCode()))
            auth.setCompany(terminalVO.getTerCode());
        String hour=new SimpleDateFormat("HH").format(new Date());
        if(Integer.parseInt(hour)>=7&&dailyTerDataLogService.findByTerCodeAndStatus(auth.getCompany(),"1")!=null){
            AuthInfo authInfo=new AuthInfo(auth.getName(),auth.getAccount(),auth.getDescription(),auth.getCompany());
            Map map=new HashMap();
            map.put("auth",authInfo);
            map.put("data",terminalVO);
            map.put("time",new Date());
            redisTemplate.opsForValue().set(auth.getCompany(),map);
            Date currentDate=new Date();
            Date afterDate= DateDeal.getSpecifiedDayAfter(currentDate);
            Long mins=DateDeal.getMins(afterDate,currentDate);
            redisTemplate.expire(auth.getCompany(),mins, TimeUnit.MINUTES);
            return SaveResult.getInstance(SaveResult.WAIT_CHANGE);
        }
        if(terminalVO.getDispersionVOList().size()>0){
            List<DispersionVO> dispersionVOS=terminalVO.getDispersionVOList();
            List<Dispersion> dispersions=new ArrayList();
            if(dispersionService.findCurrentDispersionByWharf(auth.getCompany()).size()>0)
                dispersionService.deleteCurrentBargeByTerId(auth.getCompany());
            for(int i=0;i<dispersionVOS.size();i++){
                Dispersion dispersion=new Dispersion();
                dispersion.setCargoNumber(dispersionVOS.get(i).getWorkingNumber());
                dispersion.setCargoUnworkNumber(dispersionVOS.get(i).getUnWorkNumber());
                dispersion.setMechanicalNumber(dispersionVOS.get(i).getMechanicalNumber());
                dispersion.setInsAccount(auth.getAccount());
                dispersion.setUpdAccount(auth.getAccount());
                dispersion.setTerCode(auth.getCompany());
                DispersionCargo dispersionCargo=dispersionCargoService.findByName(dispersionVOS.get(i).getCargoName());
                if(dispersionCargo==null){
                    DispersionCargo newCargo=new DispersionCargo();
                    newCargo.setCargoName(dispersionVOS.get(i).getCargoName());
                    dispersion.setCargoCode(dispersionCargoService.save(newCargo).getCargoCodeId());
                }else{
                    dispersion.setCargoCode(dispersionCargo.getCargoCodeId());
                }
                dispersions.add(dispersion);
            }
            if(dispersionService.saveInterable(dispersions)==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }

        if(terminalVO.getProductionLineList().size()>0){
            if(productionLineService.findCurrentProByTerID(auth.getCompany()).size()>0)
                productionLineService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getProductionLineList().size(); i++) {
                terminalVO.getProductionLineList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getProductionLineList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getProductionLineList().get(i).setTerCode(auth.getCompany());
            }
            if(productionLineService.saveAll(terminalVO.getProductionLineList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }

        if(terminalVO.getBargeList().size()>0){
            if(bargeService.getCurrentBargeByTerId(auth.getCompany()).size()>0)
                bargeService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getBargeList().size(); i++) {
                terminalVO.getBargeList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getBargeList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getBargeList().get(i).setTerCode(auth.getCompany());
            }
            if(bargeService.saveAll(terminalVO.getBargeList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }
        if(terminalVO.getBargeXSList().size()>0){
            if(bargeXSService.getCurrentBargeByTerId(auth.getCompany()).size()>0)
                bargeXSService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getBargeXSList().size(); i++) {
                terminalVO.getBargeXSList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getBargeXSList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getBargeXSList().get(i).setTerCode(auth.getCompany());
            }
            if(bargeXSService.saveAll(terminalVO.getBargeXSList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }
        if(terminalVO.getCntrStoreList().size()>0){
            if(cntrStoreService.getCurrentCntrStroeByTerId(auth.getCompany()).size()>0)
                cntrStoreService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getCntrStoreList().size(); i++) {
                terminalVO.getCntrStoreList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getCntrStoreList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getCntrStoreList().get(i).setTerCode(auth.getCompany());
            }
            if(cntrStoreService.saveAll(terminalVO.getCntrStoreList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }
        if(terminalVO.getTruckStoreList().size()>0){
            if(truckStoreService.findCurrentProByTerID(auth.getCompany()).size()>0)
                truckStoreService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getTruckStoreList().size(); i++) {
                terminalVO.getTruckStoreList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getTruckStoreList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getTruckStoreList().get(i).setTerCode(auth.getCompany());
            }
            if(truckStoreService.saveAll(terminalVO.getTruckStoreList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }
        if(terminalVO.getCarStoreList()!=null&&terminalVO.getCarStoreList().size()>0){
            if(carStoreService.getCurrentBargeByTerId(auth.getCompany()).size()>0)
                carStoreService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getCarStoreList().size(); i++) {
                terminalVO.getCarStoreList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getCarStoreList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getCarStoreList().get(i).setTerCode(auth.getCompany());
            }
            if(carStoreService.saveAll(terminalVO.getCarStoreList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }
        if(terminalVO.getAttendenceList().size()>0){
            if(attendenceService.findCurrentByWharf(auth.getCompany()).size()>0)
                attendenceService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getAttendenceList().size(); i++) {
                terminalVO.getAttendenceList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getAttendenceList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getAttendenceList().get(i).setTerCode(auth.getCompany());
            }
            if(attendenceService.saveAll(terminalVO.getAttendenceList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }
        if(terminalVO.getBulkStoreList().size()>0){
            if(bulkStoreService.getCurrentBulkByTerId(auth.getCompany()).size()>0)
                bulkStoreService.deleteCurrentBargeByTerId(auth.getCompany());
            for (int i = 0; i < terminalVO.getBulkStoreList().size(); i++) {
                terminalVO.getBulkStoreList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getBulkStoreList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getBulkStoreList().get(i).setTerCode(auth.getCompany());
            }
            if(bulkStoreService.saveAll(terminalVO.getBulkStoreList())==null)
                return SaveResult.getInstance(SaveResult.FAILE);
        }
        DailyTerdataLog dailyTerdataLog=new DailyTerdataLog();
        dailyTerdataLog.setTerCode(auth.getCompany());
        dailyTerdataLog.setUpdAccount(auth.getAccount());
        dailyTerdataLog.setStatus("1");
        dailyTerDataLogService.updateStatus(dailyTerdataLog);
        return SaveResult.getInstance(SaveResult.SUCCESS);
    }

    @GetMapping("/getData")
    @ApiOperation(value = "通过登录账号码头所提交的数据")
    public TerminalVO getDataByTer(){
        Auth auth = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        auth = authService.findByAccount(auth.getAccount());
        List<Dispersion> dispersions=new ArrayList();
        List<DispersionVO> dispersionVOS=new ArrayList();
        TerminalVO terminalVO=new TerminalVO();
        dispersions=dispersionService.findCurrentDispersionByWharf(auth.getCompany());
        for(int i=0;i<dispersions.size();i++){
            DispersionVO dispersionVO=new DispersionVO();
            dispersionVO.setTerCode(auth.getCompany());
            dispersionVO.setDispersionId(dispersions.get(i).getDispersionId());
            dispersionVO.setCargoName(dispersionCargoService.findByCargoCodeId(dispersions.get(i).getCargoCode()).getCargoName());
            dispersionVO.setMechanicalNumber(dispersions.get(i).getMechanicalNumber());
            dispersionVO.setWorkingNumber(dispersions.get(i).getCargoNumber());
            dispersionVO.setUnWorkNumber(dispersions.get(i).getCargoUnworkNumber());
            dispersionVOS.add(dispersionVO);
        }
        terminalVO.setDispersionVOList(dispersionVOS);
        terminalVO.setBargeList(bargeService.getCurrentBargeByTerId(auth.getCompany()));
        terminalVO.setBargeXSList(bargeXSService.getCurrentBargeByTerId(auth.getCompany()));
        terminalVO.setCntrStoreList(cntrStoreService.getCurrentCntrStroeByTerId(auth.getCompany()));
        terminalVO.setTruckStoreList(truckStoreService.findCurrentProByTerID(auth.getCompany()));
        terminalVO.setProductionLineList(productionLineService.findCurrentProByTerID(auth.getCompany()));
        terminalVO.setCarStoreList(carStoreService.getCurrentBargeByTerId(auth.getCompany()));
        terminalVO.setAttendenceList(attendenceService.findCurrentByWharf(auth.getCompany()));
        terminalVO.setBulkStoreList(bulkStoreService.getCurrentBulkByTerId(auth.getCompany()));
        return terminalVO;
    }

    @PostMapping("/getDataByTime")
    @ResponseBody
    @ApiOperation(value = "通过时间获取码头数据")
    public TerminalVO getDataByTime(@RequestBody JSONObject data){
        String time=data.getString("time");
        Auth auth = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        auth = authService.findByAccount(auth.getAccount());
        List<Dispersion> dispersions=new ArrayList();
        List<DispersionVO> dispersionVOS=new ArrayList();
        TerminalVO terminalVO=new TerminalVO();
        dispersions=dispersionService.findDispersionByWharfAndTime(auth.getCompany(),time);
        for(int i=0;i<dispersions.size();i++){
            DispersionVO dispersionVO=new DispersionVO();
            dispersionVO.setTerCode(auth.getCompany());
            dispersionVO.setDispersionId(dispersions.get(i).getDispersionId());
            dispersionVO.setCargoName(dispersionCargoService.findByCargoCodeId(dispersions.get(i).getCargoCode()).getCargoName());
            dispersionVO.setMechanicalNumber(dispersions.get(i).getMechanicalNumber());
            dispersionVO.setWorkingNumber(dispersions.get(i).getCargoNumber());
            dispersionVO.setUnWorkNumber(dispersions.get(i).getCargoUnworkNumber());
            dispersionVOS.add(dispersionVO);
        }
        terminalVO.setDispersionVOList(dispersionVOS);
        terminalVO.setBargeList(bargeService.getBargeByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setBargeXSList(bargeXSService.getBargeByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setCntrStoreList(cntrStoreService.getCntrStoreByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setTruckStoreList(truckStoreService.findProByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setProductionLineList(productionLineService.findProByTerIDAndTime(auth.getCompany(),time));
        terminalVO.setCarStoreList(carStoreService.getBargeByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setAttendenceList(attendenceService.findAttendenceByWharfAndTime(auth.getCompany(),time));
        terminalVO.setBulkStoreList(bulkStoreService.findBulkStoreByWharfAndTime(auth.getCompany(),time));
        return terminalVO;
    }

    @PostMapping("/getDataByTerCodeAndTime/{terCode}")
    @ResponseBody
    @ApiOperation(value = "通过码头，时间获取码头所填数据")
    public TerminalVO getDataByTerCodeAndTime(@PathVariable("terCode")String terCode, @RequestBody JSONObject data){
        String time=data.getString("time");
        try {
            Date time2 = new SimpleDateFormat("yyyy-MM-dd").parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Auth auth = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        auth = authService.findByAccount(auth.getAccount());
        auth.setCompany(terCode);
        List<Dispersion> dispersions=new ArrayList();
        List<DispersionVO> dispersionVOS=new ArrayList();
        TerminalVO terminalVO=new TerminalVO();
        dispersions=dispersionService.findDispersionByWharfAndTime(auth.getCompany(),time);
        for(int i=0;i<dispersions.size();i++){
            DispersionVO dispersionVO=new DispersionVO();
            dispersionVO.setTerCode(auth.getCompany());
            dispersionVO.setDispersionId(dispersions.get(i).getDispersionId());
            dispersionVO.setCargoName(dispersionCargoService.findByCargoCodeId(dispersions.get(i).getCargoCode()).getCargoName());
            dispersionVO.setMechanicalNumber(dispersions.get(i).getMechanicalNumber());
            dispersionVO.setWorkingNumber(dispersions.get(i).getCargoNumber());
            dispersionVO.setUnWorkNumber(dispersions.get(i).getCargoUnworkNumber());
            dispersionVOS.add(dispersionVO);
        }
        terminalVO.setDispersionVOList(dispersionVOS);
        terminalVO.setBargeList(bargeService.getBargeByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setBargeXSList(bargeXSService.getBargeByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setCntrStoreList(cntrStoreService.getCntrStoreByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setTruckStoreList(truckStoreService.findProByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setProductionLineList(productionLineService.findProByTerIDAndTime(auth.getCompany(),time));
        terminalVO.setCarStoreList(carStoreService.getBargeByTerIdAndTime(auth.getCompany(),time));
        terminalVO.setAttendenceList(attendenceService.findAttendenceByWharfAndTime(auth.getCompany(),time));
        terminalVO.setBulkStoreList(bulkStoreService.findBulkStoreByWharfAndTime(auth.getCompany(),time));
        return terminalVO;
    }

    @GetMapping("/getDataByTerCode/{terCode}")
    public TerminalVO getDataByTerCode(@PathVariable("terCode")String terCode){

        Auth auth = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        auth = authService.findByAccount(auth.getAccount());
        auth.setCompany(terCode);
        List<Dispersion> dispersions=new ArrayList();
        List<DispersionVO> dispersionVOS=new ArrayList();
        TerminalVO terminalVO=new TerminalVO();
        dispersions=dispersionService.findCurrentDispersionByWharf(auth.getCompany());

        for(int i=0;i<dispersions.size();i++){
            DispersionVO dispersionVO=new DispersionVO();
            dispersionVO.setTerCode(auth.getCompany());
            dispersionVO.setDispersionId(dispersions.get(i).getDispersionId());
            dispersionVO.setCargoName(dispersionCargoService.findByCargoCodeId(dispersions.get(i).getCargoCode()).getCargoName());
            dispersionVO.setMechanicalNumber(dispersions.get(i).getMechanicalNumber());
            dispersionVO.setWorkingNumber(dispersions.get(i).getCargoNumber());
            dispersionVO.setUnWorkNumber(dispersions.get(i).getCargoUnworkNumber());
            dispersionVOS.add(dispersionVO);
        }
        terminalVO.setDispersionVOList(dispersionVOS);
        terminalVO.setBargeList(bargeService.getCurrentBargeByTerId(auth.getCompany()));
        terminalVO.setBargeXSList(bargeXSService.getCurrentBargeByTerId(auth.getCompany()));
        terminalVO.setCntrStoreList(cntrStoreService.getCurrentCntrStroeByTerId(auth.getCompany()));
        terminalVO.setTruckStoreList(truckStoreService.findCurrentProByTerID(auth.getCompany()));
        terminalVO.setProductionLineList(productionLineService.findCurrentProByTerID(auth.getCompany()));
        terminalVO.setCarStoreList(carStoreService.getCurrentBargeByTerId(auth.getCompany()));
        terminalVO.setAttendenceList(attendenceService.findCurrentByWharf(auth.getCompany()));
        terminalVO.setBulkStoreList(bulkStoreService.getCurrentBulkByTerId(auth.getCompany()));
        return terminalVO;
    }

}
