package com.gzport.meeting.controller;

import com.gzport.meeting.domain.entity.Auth;
import com.gzport.meeting.domain.entity.Barge;
import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.DispersionCargo;
import com.gzport.meeting.domain.vo.DispersionVO;
import com.gzport.meeting.domain.vo.TerminalVO;
import com.gzport.meeting.service.*;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

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


    @PostMapping("/saveDate")
    @ResponseBody
    public void saveDateFromTer(@RequestBody TerminalVO terminalVO){
        Auth auth = (Auth) SecurityUtils.getSubject().getSession().getAttribute(LoginController.SESSION_USER);
        auth = authService.findByAccount(auth.getAccount());
        if(terminalVO.getDispersionVOList().size()>0){
            List<DispersionVO> dispersionVOS=terminalVO.getDispersionVOList();
            List<Dispersion> dispersions=new ArrayList();
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
            dispersionService.saveInterable(dispersions);
        }

        if(terminalVO.getProductionLineList().size()>0){
            for (int i = 0; i < terminalVO.getProductionLineList().size(); i++) {
                terminalVO.getProductionLineList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getProductionLineList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getProductionLineList().get(i).setTerCode(auth.getCompany());
            }
            productionLineService.saveAll(terminalVO.getProductionLineList());
        }

        if(terminalVO.getBargeList().size()>0){
            for (int i = 0; i < terminalVO.getBargeList().size(); i++) {
                terminalVO.getBargeList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getBargeList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getBargeList().get(i).setTerCode(auth.getCompany());
            }
            bargeService.saveAll(terminalVO.getBargeList());
        }
        if(terminalVO.getBargeXSList().size()>0){
            for (int i = 0; i < terminalVO.getBargeXSList().size(); i++) {
                terminalVO.getBargeXSList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getBargeXSList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getBargeXSList().get(i).setTerCode(auth.getCompany());
            }
            bargeXSService.saveAll(terminalVO.getBargeXSList());
        }
        if(terminalVO.getCntrStoreList().size()>0){
            for (int i = 0; i < terminalVO.getCntrStoreList().size(); i++) {
                terminalVO.getCntrStoreList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getCntrStoreList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getCntrStoreList().get(i).setTerCode(auth.getCompany());
            }
            cntrStoreService.saveAll(terminalVO.getCntrStoreList());
        }
        if(terminalVO.getTruckStoreList().size()>0){
            for (int i = 0; i < terminalVO.getTruckStoreList().size(); i++) {
                terminalVO.getTruckStoreList().get(i).setInsAccount(auth.getAccount());
                terminalVO.getTruckStoreList().get(i).setUpdAccount(auth.getAccount());
                terminalVO.getTruckStoreList().get(i).setTerCode(auth.getCompany());
            }
            truckStoreService.saveAll(terminalVO.getTruckStoreList());
        }
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
            dispersionVO.setCargoName(dispersionCargoService.findByCargoCode(dispersions.get(i).getCargoCode()).getCargoName());
            dispersionVO.setMechanicalNumber(dispersions.get(i).getMechanicalNumber());
            dispersionVO.setWorkingNumber(dispersions.get(i).getCargoNumber());
            dispersionVO.setUnWorkNumber(dispersions.get(i).getCargoUnworkNumber());
            dispersionVOS.add(dispersionVO);
        }
        terminalVO.setDispersionVOList(dispersionVOS);
        terminalVO.setBargeList(bargeService.getCurrentBargeByTerId(auth.getAccount()));
        terminalVO.setBargeXSList(bargeXSService.getCurrentBargeByTerId(auth.getAccount()));
        terminalVO.setCntrStoreList(cntrStoreService.getCurrentCntrStroeByTerId(auth.getAccount()));
        terminalVO.setTruckStoreList(truckStoreService.findCurrentProByTerID(auth.getAccount()));
        terminalVO.setProductionLineList(productionLineService.findCurrentProByTerID(auth.getAccount()));
        return terminalVO;
    }
}