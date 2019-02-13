package com.gzport.meeting.domain.vo;

/**
 * Created by zhangxiang on 2019/2/12.
 */
public class BargeWorkVO {
    private String statue;
    private Integer bargeNumber;

    public String getStatue() {
        return statue;
    }

    public void setStatue(String statue) {
        this.statue = statue;
    }

    public Integer getBargeNumber() {
        return bargeNumber;
    }

    public void setBargeNumber(Integer bargeNumber) {
        this.bargeNumber = bargeNumber;
    }

    public BargeWorkVO() {
    }

    public BargeWorkVO(String statue, Integer bargeNumber) {
        this.statue = statue;
        this.bargeNumber = bargeNumber;
    }
}
