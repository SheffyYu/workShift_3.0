package com.gzport.meeting.domain.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/26.
 */
@Entity
@Table(name="YEAR_PLAN_THROUGHPUT")
public class YearPlanThroughput implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name = "YEAR_PLAN_THROUGHPUT_ID")
    private String yearPlanThroughputId;

    @Column(name="CNTR_YEAR_THROUGHT")
    private Integer cntrYearThroughput;

    @Column(name="CARGO_YEAR_THROUGHT")
    private Integer cargoYearThroughput;

    @Column(name="TH_YEAR")
    @Size(min=1,max = 4)
    private String year;

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

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getYearPlanThroughputId() {
        return yearPlanThroughputId;
    }

    public void setYearPlanThroughputId(String yearPlanThroughputId) {
        this.yearPlanThroughputId = yearPlanThroughputId;
    }

    public Integer getCntrYearThroughput() {
        return cntrYearThroughput;
    }

    public void setCntrYearThroughput(Integer cntrYearThroughput) {
        this.cntrYearThroughput = cntrYearThroughput;
    }

    public Integer getCargoYearThroughput() {
        return cargoYearThroughput;
    }

    public void setCargoYearThroughput(Integer cargoYearThroughput) {
        this.cargoYearThroughput = cargoYearThroughput;
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
