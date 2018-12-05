package com.gzport.meeting.domain.entity;

import org.eclipse.persistence.annotations.UuidGenerator;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by yushihui on 2018/11/28.
 */
@Entity
@Table(name = "TRUCK_STORE")
public class TruckStore implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name = "TRUCK_STORE_ID")
    private String truckStoreId;
    @Column(name="TER_CODE")
    private String terCode;      //码头Id
    @Column(name = "TOTAL_LOAD")
    private long totalLoad;     //新港片装车合计
    @Column(name = "LOAD_INPORT")
    private long loadInport;    //港内装车合计
    @Column(name = "LOAD_OUTPORT")
    private long loadOutPort;   //港外装车合计
    @Column(name = "LOADI_XG")     //港内
    private long loadiXg;        //新港装车
    @Column(name = "LOADI_XJ")
    private long loadiXj;        //西基装车
    @Column(name = "LOADI_GCT")
    private long loadiGct;       //集司装车
    @Column(name = "LOADI_XS")
    private long loadiXs;        //新沙装车
    @Column(name = "LOADI_COAL")
    private long loadiCoal;     //煤炭装车
    @Column(name = "LOADI_ORE")
    private long loadiOre;      //矿石装车
    @Column(name = "LOADI_OTHER")
    private long loadiOther;        //其他装车
    @Column(name = "LOADO_COAL")    //港外
    private long loadoCoal;     //港外煤炭装车
    @Column(name = "LOADO_ORE")
    private long loadoOre;      //港外矿石装车
    @Column(name = "LOADO_OTHER")
    private long loadoOther;        //港外装车其他
    @Column(name = "UNLOAD_TRUCK")
    private long unloadTruck;   //卸车
    @Column(name = "WAIT_UNLOAD")
    private long waitUnload;    //待卸车
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

    public String getTruckStoreId() {
        return truckStoreId;
    }

    public void setTruckStoreId(String truckStoreId) {
        this.truckStoreId = truckStoreId;
    }

    public long getTotalLoad() {
        return totalLoad;
    }

    public void setTotalLoad(long totalLoad) {
        this.totalLoad = totalLoad;
    }

    public long getLoadInport() {
        return loadInport;
    }

    public void setLoadInport(long loadInport) {
        this.loadInport = loadInport;
    }

    public long getLoadOutPort() {
        return loadOutPort;
    }

    public void setLoadOutPort(long loadOutPort) {
        this.loadOutPort = loadOutPort;
    }

    public long getLoadiXg() {
        return loadiXg;
    }

    public void setLoadiXg(long loadiXg) {
        this.loadiXg = loadiXg;
    }

    public long getLoadiXj() {
        return loadiXj;
    }

    public void setLoadiXj(long loadiXj) {
        this.loadiXj = loadiXj;
    }

    public long getLoadiGct() {
        return loadiGct;
    }

    public void setLoadiGct(long loadiGct) {
        this.loadiGct = loadiGct;
    }

    public long getLoadiXs() {
        return loadiXs;
    }

    public void setLoadiXs(long loadiXs) {
        this.loadiXs = loadiXs;
    }

    public long getLoadiCoal() {
        return loadiCoal;
    }

    public void setLoadiCoal(long loadiCoal) {
        this.loadiCoal = loadiCoal;
    }

    public long getLoadiOre() {
        return loadiOre;
    }

    public void setLoadiOre(long loadiOre) {
        this.loadiOre = loadiOre;
    }

    public long getLoadiOther() {
        return loadiOther;
    }

    public void setLoadiOther(long loadiOther) {
        this.loadiOther = loadiOther;
    }

    public long getLoadoCoal() {
        return loadoCoal;
    }

    public void setLoadoCoal(long loadoCoal) {
        this.loadoCoal = loadoCoal;
    }

    public long getLoadoOre() {
        return loadoOre;
    }

    public void setLoadoOre(long loadoOre) {
        this.loadoOre = loadoOre;
    }

    public long getLoadoOther() {
        return loadoOther;
    }

    public void setLoadoOther(long loadoOther) {
        this.loadoOther = loadoOther;
    }

    public long getUnloadTruck() {
        return unloadTruck;
    }

    public void setUnloadTruck(long unloadTruck) {
        this.unloadTruck = unloadTruck;
    }

    public long getWaitUnload() {
        return waitUnload;
    }

    public void setWaitUnload(long waitUnload) {
        this.waitUnload = waitUnload;
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

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
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
