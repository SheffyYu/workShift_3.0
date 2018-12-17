package com.gzport.meeting.domain.vo;

import com.gzport.meeting.domain.entity.*;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public class TerminalVO {

    List<DispersionVO> dispersionVOList;
    List<ProductionLine> productionLineList;
    List<Barge> bargeList;
    List<TruckStore> truckStoreList;
    List<CntrStore> cntrStoreList;
    List<BargeXS> bargeXSList;
    List<CarStore> carStoreList;

    public List<CarStore> getCarStoreList() {
        return carStoreList;
    }

    public void setCarStoreList(List<CarStore> carStoreList) {
        this.carStoreList = carStoreList;
    }

    public List<BargeXS> getBargeXSList() {
        return bargeXSList;
    }

    public void setBargeXSList(List<BargeXS> bargeXSList) {
        this.bargeXSList = bargeXSList;
    }

    public List<CntrStore> getCntrStoreList() {
        return cntrStoreList;
    }

    public void setCntrStoreList(List<CntrStore> cntrStoreList) {
        this.cntrStoreList = cntrStoreList;
    }

    public List<DispersionVO> getDispersionVOList() {
        return dispersionVOList;
    }

    public void setDispersionVOList(List<DispersionVO> dispersionVOList) {
        this.dispersionVOList = dispersionVOList;
    }

    public List<ProductionLine> getProductionLineList() {
        return productionLineList;
    }

    public void setProductionLineList(List<ProductionLine> productionLineList) {
        this.productionLineList = productionLineList;
    }

    public List<Barge> getBargeList() {
        return bargeList;
    }

    public void setBargeList(List<Barge> bargeList) {
        this.bargeList = bargeList;
    }

    public List<TruckStore> getTruckStoreList() {
        return truckStoreList;
    }

    public void setTruckStoreList(List<TruckStore> truckStoreList) {
        this.truckStoreList = truckStoreList;
    }
}
