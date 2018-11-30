package com.gzport.meeting.domain.entity;

import org.eclipse.persistence.annotations.UuidGenerator;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/11/28.
 */
@Entity
@Table(name = "PRODUCTION_LINE")
public class ProductionLine implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
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
