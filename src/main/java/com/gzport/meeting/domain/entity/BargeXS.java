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

    @Column(name="BARGE_NUMBER")
    private Integer bargeNumber;

    @Column(name="WORKING_NUMBER")
    private Integer workingNumber;

    @Column(name="IS_WORKING_NUMBER")
    private Integer unWorkNumber;

    @Column(name="BARGE_SHENZHEN_NUMBER")
    private Integer bargeShenzhenNumber;

    @Column(name="BARGE_IT_NUMBER")
    private Integer bargeItNumber;

    @Column(name="BARGE_ET_NUMBER")
    private Integer bargeEtNumber;

    @Column(name="BARGE_SHUTTLEBUS_NUMBER")
    private Integer bargeShuttlebusNumber;

    @Column(name="LINE_NUMBER")
    private Integer lineNumber;

    @Column(name="LINE_SHUTTLEBUS_NUMBER")
    private Integer lineShuttlebusNumber;

    @Column(name="LINE_SHENZHEN_NUMBER")
    private Integer lineShenzhenNumber;

    @Column(name="LINE_IT_NUMBER")
    private Integer lineItNumber;

    @Column(name="LINE_ET_NUMBER")
    private Integer lineEtNumber;

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

    public Integer getBargeNumber() {
        return bargeNumber;
    }

    public void setBargeNumber(Integer bargeNumber) {
        this.bargeNumber = bargeNumber;
    }

    public Integer getWorkingNumber() {
        return workingNumber;
    }

    public void setWorkingNumber(Integer workingNumber) {
        this.workingNumber = workingNumber;
    }

    public Integer getUnWorkNumber() {
        return unWorkNumber;
    }

    public void setUnWorkNumber(Integer unWorkNumber) {
        this.unWorkNumber = unWorkNumber;
    }

    public Integer getBargeShenzhenNumber() {
        return bargeShenzhenNumber;
    }

    public void setBargeShenzhenNumber(Integer bargeShenzhenNumber) {
        this.bargeShenzhenNumber = bargeShenzhenNumber;
    }

    public Integer getBargeItNumber() {
        return bargeItNumber;
    }

    public void setBargeItNumber(Integer bargeItNumber) {
        this.bargeItNumber = bargeItNumber;
    }

    public Integer getBargeEtNumber() {
        return bargeEtNumber;
    }

    public void setBargeEtNumber(Integer bargeEtNumber) {
        this.bargeEtNumber = bargeEtNumber;
    }

    public Integer getBargeShuttlebusNumber() {
        return bargeShuttlebusNumber;
    }

    public void setBargeShuttlebusNumber(Integer bargeShuttlebusNumber) {
        this.bargeShuttlebusNumber = bargeShuttlebusNumber;
    }

    public Integer getLineNumber() {
        return lineNumber;
    }

    public void setLineNumber(Integer lineNumber) {
        this.lineNumber = lineNumber;
    }

    public Integer getLineShuttlebusNumber() {
        return lineShuttlebusNumber;
    }

    public void setLineShuttlebusNumber(Integer lineShuttlebusNumber) {
        this.lineShuttlebusNumber = lineShuttlebusNumber;
    }

    public Integer getLineShenzhenNumber() {
        return lineShenzhenNumber;
    }

    public void setLineShenzhenNumber(Integer lineShenzhenNumber) {
        this.lineShenzhenNumber = lineShenzhenNumber;
    }

    public Integer getLineItNumber() {
        return lineItNumber;
    }

    public void setLineItNumber(Integer lineItNumber) {
        this.lineItNumber = lineItNumber;
    }

    public Integer getLineEtNumber() {
        return lineEtNumber;
    }

    public void setLineEtNumber(Integer lineEtNumber) {
        this.lineEtNumber = lineEtNumber;
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
