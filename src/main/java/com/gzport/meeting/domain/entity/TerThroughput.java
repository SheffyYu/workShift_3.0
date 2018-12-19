package com.gzport.meeting.domain.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/19.
 */

@Entity
@Table(name="TER_THROUGHPUT")
public class TerThroughput implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name = "TER_THROUGHPUT_ID")
    private String terThroughputId;

    @Column(name="TER_CODE")
    private String terCode;

    @Column(name="MONTHLY_PLAN")
    private BigDecimal monthlyPlan;

    @Column(name="MONTHLY_TOTAL")
    private BigDecimal monthlyTotal;

    @Column(name="MONTHLY_PER")
    private BigDecimal monthlyPer;

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

    public String getTerThroughputId() {
        return terThroughputId;
    }

    public void setTerThroughputId(String terThroughputId) {
        this.terThroughputId = terThroughputId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public BigDecimal getMonthlyPlan() {
        return monthlyPlan;
    }

    public void setMonthlyPlan(BigDecimal monthlyPlan) {
        this.monthlyPlan = monthlyPlan;
    }

    public BigDecimal getMonthlyTotal() {
        return monthlyTotal;
    }

    public void setMonthlyTotal(BigDecimal monthlyTotal) {
        this.monthlyTotal = monthlyTotal;
    }

    public BigDecimal getMonthlyPer() {
        return monthlyPer;
    }

    public void setMonthlyPer(BigDecimal monthlyPer) {
        this.monthlyPer = monthlyPer;
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
