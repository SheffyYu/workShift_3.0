package com.gzport.meeting.domain.entity;

import io.swagger.models.auth.In;
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
    @Column(name ="BARGEXS_ID")
    private String bargeXSId;

    @Column(name="TER_CODE")
    private String terCode;

    @Column(name="WORK_TYPE")
    private String workType;

    @Column(name="TOTAL_NUMBER")
    private Integer totalNumber;

    @Column(name="SHENZHEN_NUMBER")
    private Integer shenzhenNumber;

    @Column(name="IT_NUMBER")
    private Integer itNumber;

    @Column(name="ET_NUMBER")
    private Integer etNumber;

    @Column(name="SHUTTLEBUS_NUMBER")
    private Integer shuttlebusNumber;


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

    public String getBargeXSId() {
        return bargeXSId;
    }

    public void setBargeXSId(String bargeXSId) {
        this.bargeXSId = bargeXSId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public Integer getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(Integer totalNumber) {
        this.totalNumber = totalNumber;
    }

    public Integer getShenzhenNumber() {
        return shenzhenNumber;
    }

    public void setShenzhenNumber(Integer shenzhenNumber) {
        this.shenzhenNumber = shenzhenNumber;
    }

    public Integer getItNumber() {
        return itNumber;
    }

    public void setItNumber(Integer itNumber) {
        this.itNumber = itNumber;
    }

    public Integer getEtNumber() {
        return etNumber;
    }

    public void setEtNumber(Integer etNumber) {
        this.etNumber = etNumber;
    }

    public Integer getShuttlebusNumber() {
        return shuttlebusNumber;
    }

    public void setShuttlebusNumber(Integer shuttlebusNumber) {
        this.shuttlebusNumber = shuttlebusNumber;
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
