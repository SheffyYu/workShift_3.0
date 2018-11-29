package com.gzport.meeting.domain.entity;

import org.eclipse.persistence.annotations.UuidGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

/**
 * Created by zhangxiang on 2018/11/28.
 */
@Entity
@Table(name = "DISPERSION")
public class Dispersion implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @UuidGenerator(name = "UUID")
    @GeneratedValue(generator = "UUID")
    @Column(name ="DISPERSION_ID")
    private String dispersionId;

    @Column(name="TER_CODE")
    private String terCode;

    @Column(name="CARGO_CODE")
    private String cargoCode;

    @Column(name="CARGO_NUMBER")
    private Long cargoNumber;

    @Column(name="CARGO_STATE")
    private String cargoState;

    @Column(name="REMARK")
    private String remark;

    @Column(name="MECHANICAL_NUMBER")
    private Integer mechanicalNumber;

    @Column(name="INS_ACCOUNT")
    private String insAccount;

    @Column(name="INS_TIMESTAMP")
    private Date insTimestamp;

    @Column(name="UPD_ACCOUNT")
    private String updAccount;

    @Column(name="UPD_TIMESTAMP")
    private Date updTimestamp;

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

    public Integer getMechanicalNumber() {
        return mechanicalNumber;
    }

    public void setMechanicalNumber(Integer mechanicalNumber) {
        this.mechanicalNumber = mechanicalNumber;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getDispersionId() {
        return dispersionId;
    }

    public void setDispersionId(String dispersionId) {
        this.dispersionId = dispersionId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public String getCargoCode() {
        return cargoCode;
    }

    public void setCargoCode(String cargoCode) {
        this.cargoCode = cargoCode;
    }

    public Long getCargoNumber() {
        return cargoNumber;
    }

    public void setCargoNumber(Long cargoNumber) {
        this.cargoNumber = cargoNumber;
    }

    public String getCargoState() {
        return cargoState;
    }

    public void setCargoState(String cargoState) {
        this.cargoState = cargoState;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}