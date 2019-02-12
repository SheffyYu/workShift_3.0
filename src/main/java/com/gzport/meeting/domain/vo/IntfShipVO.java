package com.gzport.meeting.domain.vo;

import java.sql.Date;

/**
 * Created by zhangxiang on 2019/2/12.
 */
public class IntfShipVO {

    private Date createDate;

    private Integer shipNumber;

    private String shipStatue;

    private Integer tradeNumber;

    private Integer workNumber;

    public IntfShipVO() {
    }

    public IntfShipVO(Date createDate, Integer shipNumber, String shipStatue, Integer tradeNumber, Integer workNumber) {
        this.createDate = createDate;
        this.shipNumber = shipNumber;
        this.shipStatue = shipStatue;
        this.tradeNumber = tradeNumber;
        this.workNumber = workNumber;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getShipNumber() {
        return shipNumber;
    }

    public void setShipNumber(Integer shipNumber) {
        this.shipNumber = shipNumber;
    }

    public String getShipStatue() {
        return shipStatue;
    }

    public void setShipStatue(String shipStatue) {
        this.shipStatue = shipStatue;
    }

    public Integer getTradeNumber() {
        return tradeNumber;
    }

    public void setTradeNumber(Integer tradeNumber) {
        this.tradeNumber = tradeNumber;
    }

    public Integer getWorkNumber() {
        return workNumber;
    }

    public void setWorkNumber(Integer workNumber) {
        this.workNumber = workNumber;
    }
}
