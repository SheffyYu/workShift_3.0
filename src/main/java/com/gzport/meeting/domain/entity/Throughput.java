package com.gzport.meeting.domain.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/10.
 */
@Entity
@Table(name="THROUGHPUT")
public class Throughput implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name = "THROUGHPUT_ID")
    private String throughputId;

    @Column(name="DAILY_TOTAL")
    private BigDecimal dailyTotal;

    @Column(name="THROUGHPUT_NTC")
    private BigDecimal throuthputNTC;

    @Column(name="THROUGHPUT_GOCT")
    private BigDecimal throughputGOCT;

    @Column(name="THROUGHPUT_NICT")
    private BigDecimal ThroughputNICT;

    @Column(name="TH_CARGO_TOTAL")     //每月货物吞吐量总计
    private BigDecimal thCargoTotal;

    @Column(name="CARGO_TOTAL_PER")
    private BigDecimal cargoTotalPer;

    @Column(name="TH_CARGO_PLAN")       //每月货物吞吐量计划
    private String thCargoPlan;

    @Column(name="TH_CNTR_TOTAL")       //每月集装箱吞吐量
    private BigDecimal thCntrTotal;

    @Column(name="CNTR_TOTAL_PER")
    private BigDecimal cntrTotalPer;

    @Column(name="TH_CNTR_PLAN")        //每月集装箱吞吐量计划
    private String thCntrPlan;

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


    public BigDecimal getDailyTotal() {
        return dailyTotal;
    }

    public void setDailyTotal(BigDecimal dailyTotal) {
        this.dailyTotal = dailyTotal;
    }

    public BigDecimal getThrouthputNTC() {
        return throuthputNTC;
    }

    public void setThrouthputNTC(BigDecimal throuthputNTC) {
        this.throuthputNTC = throuthputNTC;
    }

    public BigDecimal getThroughputGOCT() {
        return throughputGOCT;
    }

    public void setThroughputGOCT(BigDecimal throughputGOCT) {
        this.throughputGOCT = throughputGOCT;
    }

    public BigDecimal getThroughputNICT() {
        return ThroughputNICT;
    }

    public void setThroughputNICT(BigDecimal throughputNICT) {
        ThroughputNICT = throughputNICT;
    }

    public BigDecimal getThCargoTotal() {
        return thCargoTotal;
    }

    public void setThCargoTotal(BigDecimal thCargoTotal) {
        this.thCargoTotal = thCargoTotal;
    }

    public BigDecimal getCargoTotalPer() {
        return cargoTotalPer;
    }

    public void setCargoTotalPer(BigDecimal cargoTotalPer) {
        this.cargoTotalPer = cargoTotalPer;
    }

    public BigDecimal getThCntrTotal() {
        return thCntrTotal;
    }

    public void setThCntrTotal(BigDecimal thCntrTotal) {
        this.thCntrTotal = thCntrTotal;
    }

    public BigDecimal getCntrTotalPer() {
        return cntrTotalPer;
    }

    public void setCntrTotalPer(BigDecimal cntrTotalPer) {
        this.cntrTotalPer = cntrTotalPer;
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

    public String getThroughputId() {
        return throughputId;
    }

    public void setThroughputId(String throughputId) {
        this.throughputId = throughputId;
    }


    public String getThCargoPlan() {
        return thCargoPlan;
    }

    public void setThCargoPlan(String thCargoPlan) {
        this.thCargoPlan = thCargoPlan;
    }

    public String getThCntrPlan() {
        return thCntrPlan;
    }

    public void setThCntrPlan(String thCntrPlan) {
        this.thCntrPlan = thCntrPlan;
    }

    @PrePersist
    protected void prePersist(){
        if(this.insTimestamp == null){
            insTimestamp= new Date();
        }
        if(this.updTimestamp == null){
            updTimestamp=new Date();
        }
    }

    @PreUpdate
    protected void preUpdate(){
        this.updTimestamp=new Date();
    }
}
