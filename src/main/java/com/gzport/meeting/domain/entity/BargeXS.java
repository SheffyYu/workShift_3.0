package com.gzport.meeting.domain.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/4.
 */

@Entity
@Table(name = "BARGE_XS")
public class BargeXS implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name ="BARGE_ID")
    private String bargeId;

    @Column(name="TER_CODE")
    private String terCode;

    @Column(name="SHIP_NUMBER")
    private Integer shipNumber;

    @Column(name="WORKING_NUMBER")
    private Integer workingNumber;

    @Column(name="IS_WORKING_NUMBER")
    private Integer isWorkingNumber;

    @Column(name="SHUTTLEBUS_NUMBER")
    private Integer shuttlebusNumber;

    @Column(name="BARGE_DT_NUMBER")
    private Integer bargeDtNumber;

    @Column(name="BARGE_FT_NUMBER")
    private Integer bargeFtNumber;

    @Column(name="INS_ACCOUNT")
    private String insAccount;

    @Column(name="INS_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date insTimestamp;

    @Column(name="UPD_ACCOUNT")
    private String updAccount;

    @Column(name="UPD_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updTimestamp;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getBargeId() {
        return bargeId;
    }

    public void setBargeId(String bargeId) {
        this.bargeId = bargeId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public Integer getShipNumber() {
        return shipNumber;
    }

    public void setShipNumber(Integer shipNumber) {
        this.shipNumber = shipNumber;
    }

    public Integer getWorkingNumber() {
        return workingNumber;
    }

    public void setWorkingNumber(Integer workingNumber) {
        this.workingNumber = workingNumber;
    }

    public Integer getIsWorkingNumber() {
        return isWorkingNumber;
    }

    public void setIsWorkingNumber(Integer isWorkingNumber) {
        this.isWorkingNumber = isWorkingNumber;
    }

    public Integer getShuttlebusNumber() {
        return shuttlebusNumber;
    }

    public void setShuttlebusNumber(Integer shuttlebusNumber) {
        this.shuttlebusNumber = shuttlebusNumber;
    }

    public Integer getBargeDtNumber() {
        return bargeDtNumber;
    }

    public void setBargeDtNumber(Integer bargeDtNumber) {
        this.bargeDtNumber = bargeDtNumber;
    }

    public Integer getBargeFtNumber() {
        return bargeFtNumber;
    }

    public void setBargeFtNumber(Integer bargeFtNumber) {
        this.bargeFtNumber = bargeFtNumber;
    }

    public String getInsAccount() {
        return insAccount;
    }

    public void setInsAccount(String insAccount) {
        this.insAccount = insAccount;
    }

    public Date getInsTimestamp() {
        return insTimestamp;
    }

    public void setInsTimestamp(Date insTimestamp) {
        this.insTimestamp = insTimestamp;
    }

    public String getUpdAccount() {
        return updAccount;
    }

    public void setUpdAccount(String updAccount) {
        this.updAccount = updAccount;
    }

    public Date getUpdTimestamp() {
        return updTimestamp;
    }

    public void setUpdTimestamp(Date updTimestamp) {
        this.updTimestamp = updTimestamp;
    }
}
