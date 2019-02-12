package com.gzport.meeting.domain.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhangxiang on 2019/1/16.
 */
@Entity
@Table(name="INTF_SHIP")
public class IntfShip  implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="ROWID")
    String rowid;

    @Column(name="CREATE_DATE")
    private Date createDate;

    @Column(name="SHIP_NUMBER")
    private Integer shipNumber;

    @Column(name="SHIP_STATUE")
    private String shipStatue;

    @Column(name="TRADEE_NUMBER")
    private Integer tradeNumber;

    @Column(name="WORK_NUMBER")
    private Integer workNumber;

    public String getRowid() {
        return rowid;
    }

    public void setRowid(String rowid) {
        this.rowid = rowid;
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
