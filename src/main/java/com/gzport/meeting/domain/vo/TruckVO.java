package com.gzport.meeting.domain.vo;

/**
 * Created by zhangxiang on 2019/2/1.
 */
public class TruckVO {
    private String truckNmae;
    private Long number;

    public TruckVO() {
    }

    public TruckVO(String truckNmae, Long number) {
        this.truckNmae = truckNmae;
        this.number = number;
    }

    public String getTerNmae() {
        return truckNmae;
    }

    public void setTerNmae(String truckNmae) {
        this.truckNmae = truckNmae;
    }

    public Long getNumber() {
        return number;
    }

    public void setNumber(Long number) {
        this.number = number;
    }
}
