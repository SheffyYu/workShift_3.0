package com.gzport.meeting.domain.vo;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public class DispersionVO {
    private String terCode;
    private String cargoName;
    private Long workingNumber;
    private Long unWorkNumber;
    private Integer mechanicalNumber;


    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public String getCargoName() {
        return cargoName;
    }

    public void setCargoName(String cargoName) {
        this.cargoName = cargoName;
    }

    public Long getWorkingNumber() {
        return workingNumber;
    }

    public void setWorkingNumber(Long workingNumber) {
        this.workingNumber = workingNumber;
    }

    public Long getUnWorkNumber() {
        return unWorkNumber;
    }

    public void setUnWorkNumber(Long unWorkNumber) {
        this.unWorkNumber = unWorkNumber;
    }

    public Integer getMechanicalNumber() {
        return mechanicalNumber;
    }

    public void setMechanicalNumber(Integer mechanicalNumber) {
        this.mechanicalNumber = mechanicalNumber;
    }
}
