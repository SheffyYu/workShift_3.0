package com.gzport.meeting.domain.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by yushihui on 2018/11/28.
 */

@Entity
@Table(name = "CNTR_STORE")
public class CntrStore {
    @Id
    @Column(name = "CNTR_STORE_ID")
    private String cntrStoreId;
    @Column(name = "TER_CODE")
    private String terCode;     //公司

    @Column(name = "LOAD_CNTR_I")
    private long loadCntrI;     //重箱内贸
    @Column(name = "LOAD_CNTR_E")
    private long loadCntrE;     //重箱外贸
    @Column(name = "EMP_CNTR")
    private long empCntr;       //空箱
    @Column(name = "TOTAL_CNTR")
    private long totalCntr;     //合计

    @Column(name = "INS_ACCOUNT")
    private String insAccount;
    @Column(name = "INS_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date insTimestamp;
    @Column(name = "UPD_ACCOUNT")
    private String updAccount;
    @Column(name = "UPD_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updTimestamp;

    public String getCntrStoreId() {
        return cntrStoreId;
    }

    public void setCntrStoreId(String cntrStoreId) {
        this.cntrStoreId = cntrStoreId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public long getLoadCntrI() {
        return loadCntrI;
    }

    public void setLoadCntrI(long loadCntrI) {
        this.loadCntrI = loadCntrI;
    }

    public long getLoadCntrE() {
        return loadCntrE;
    }

    public void setLoadCntrE(long loadCntrE) {
        this.loadCntrE = loadCntrE;
    }

    public long getEmpCntr() {
        return empCntr;
    }

    public void setEmpCntr(long empCntr) {
        this.empCntr = empCntr;
    }

    public long getTotalCntr() {
        return totalCntr;
    }

    public void setTotalCntr(long totalCntr) {
        this.totalCntr = totalCntr;
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
