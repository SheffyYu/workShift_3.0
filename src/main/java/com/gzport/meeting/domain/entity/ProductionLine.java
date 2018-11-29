package com.gzport.meeting.domain.entity;

import org.eclipse.persistence.annotations.UuidGenerator;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.io.Serializable;
import java.sql.Date;

/**
 * Created by zhangxiang on 2018/11/28.
 */
public class ProductionLine implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @UuidGenerator(name = "UUID")
    @GeneratedValue(generator = "UUID")
    @Column(name ="PRODUCTION_ID")
    private String productionId;

    @Column(name = "TER_CODE")
    private String terCode;

    @Column(name = "TOTAL_LINE")
    private Integer totalLine;

    @Column(name = "SHIP_LINE")
    private Integer shipLine;

    @Column(name="BARGE_LINE")
    private Integer bargeLine;

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

    public String getProductionId() {
        return productionId;
    }

    public void setProductionId(String productionId) {
        this.productionId = productionId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public Integer getTotalLine() {
        return totalLine;
    }

    public void setTotalLine(Integer totalLine) {
        this.totalLine = totalLine;
    }

    public Integer getShipLine() {
        return shipLine;
    }

    public void setShipLine(Integer shipLine) {
        this.shipLine = shipLine;
    }

    public Integer getBargeLine() {
        return bargeLine;
    }

    public void setBargeLine(Integer bargeLine) {
        this.bargeLine = bargeLine;
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
