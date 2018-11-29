package com.gzport.meeting.domain.entity;

import org.eclipse.persistence.annotations.UuidGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

/**
 * Created by zhangxiang on 2018/11/28.
 */
@Entity
@Table(name="DISPERSION_CARGO")
public class DispersionCargo implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @UuidGenerator(name = "UUID")
    @GeneratedValue(generator = "UUID")
    @Column(name ="CARGO_CODE_ID")
    private String cargoCodeId;

    @Column(name="CARGO_NAME")
    private String cargoName;

    @Column(name="CARGO_CODE",columnDefinition = "VARCHAR2(20)")
    private String cargoCode;

    @Column(name="DESCRIPTION",columnDefinition = "VARCHAR2(1000)")
    private String description;

    @Column(name="INS_ACCOUNT")
    private String insAccount;

    @Column(name="INS_TIMESTAMP")
    private Date insTimestamp;

    @Column(name="UPD_ACCOUNT")
    private String updAccount;

    @Column(name="UPD_TIMESTAMP")
    private Date updTimestamp;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getCargoCodeId() {
        return cargoCodeId;
    }

    public void setCargoCodeId(String cargoCodeId) {
        this.cargoCodeId = cargoCodeId;
    }

    public String getCargoName() {
        return cargoName;
    }

    public void setCargoName(String cargoName) {
        this.cargoName = cargoName;
    }

    public String getCargoCode() {
        return cargoCode;
    }

    public void setCargoCode(String cargoCode) {
        this.cargoCode = cargoCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
