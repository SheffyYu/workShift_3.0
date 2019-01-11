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

    @PostMapping("/saveData")
    @ResponseBody
    public SaveResult saveDateFromTer(@RequestBody TerminalVO terminalVO){
        Auth user = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        user = authService.findByAccount(user.getAccount());
        String time=terminalVO.getDataTime();
        Date dataTime=DateDeal.DateConvert(time);
        System.out.println(dataTime);
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
        DailyTerdataLog dailyTerdataLog=new DailyTerdataLog();
        dailyTerdataLog.setTerCode(auth.getCompany());
        dailyTerdataLog.setUpdAccount(auth.getAccount());
        dailyTerdataLog.setStatus("1");
        dailyTerDataLogService.updateStatus(dailyTerdataLog);
        return SaveResult.getInstance(SaveResult.SUCCESS);
    }

    @GetMapping("/getData")
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
        return terminalVO;
    }

    @PostMapping("/getDataByTime")
    @ResponseBody
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
        return terminalVO;
    }

    @PostMapping("/getDataByTerCodeAndTime/{terCode}")
    @ResponseBody
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
        return terminalVO;
    }

    @GetMapping("/checkCurrentDate")
    public String checkAllCurrentDate(){
        return null;
    }
}
