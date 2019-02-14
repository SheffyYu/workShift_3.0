package com.gzport.meeting.domain.vo;

/**
 * Created by zhangxiang on 2019/2/14.
 */
public class ScreenDispersionVO {
    private String statue;
    private Long cargoNumber;
    private String cargoName;

    public ScreenDispersionVO() {

    }

    public ScreenDispersionVO(String statue, Long cargoNumber, String cargoName) {
        this.statue = statue;
        this.cargoNumber = cargoNumber;
        this.cargoName = cargoName;
    }

    public String getStatue() {
        return statue;
    }

    public void setStatue(String statue) {
        this.statue = statue;
    }

    public Long getCargoNumber() {
        return cargoNumber;
    }

    public void setCargoNumber(Long cargoNumber) {
        this.cargoNumber = cargoNumber;
    }

    public String getCargoName() {
        return cargoName;
    }

    public void setCargoName(String cargoName) {
        this.cargoName = cargoName;
    }
}
