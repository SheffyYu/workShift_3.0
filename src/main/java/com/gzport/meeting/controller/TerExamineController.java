package com.gzport.meeting.controller;

import com.gzport.meeting.common.SaveResult;
import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.DailyTerdataLog;
import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.DispersionCargo;
import com.gzport.meeting.domain.vo.DispersionVO;
import com.gzport.meeting.domain.vo.TerminalVO;
import com.gzport.meeting.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * Created by zhangxiang on 2018/12/28.
 */
@RestController
@RequestMapping("/login")
public class TerExamineController {

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

    @PostMapping("/examine")
    @ResponseBody
    public SaveResult TerDataExamine(@RequestBody String terCode){
        Map map=(Map) redisTemplate.opsForValue().get(terCode);
        if(map!=null){
            Auth auth=(Auth) map.get("auth");
            TerminalVO terminalVO=(TerminalVO)map.get("data");
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
            redisTemplate.delete(terCode);
            return SaveResult.getInstance(SaveResult.SUCCESS);
        }
        redisTemplate.delete(terCode);
        return SaveResult.getInstance(SaveResult.SUCCESS);
    }

    @GetMapping("/getAllKey")
    public List<Map> getAllKey(){
        List<Map> list=new ArrayList<>();
        Set<String> keys=redisTemplate.keys("*");
        for(String key:keys){
            Map value=(Map)redisTemplate.opsForValue().get(key);
            list.add(value);
        }
        return list;
    }

    @PostMapping("/unPass")
    @ResponseBody
    public boolean rejectChange(@RequestBody String terCode){
        return redisTemplate.delete(terCode);
    }
}
