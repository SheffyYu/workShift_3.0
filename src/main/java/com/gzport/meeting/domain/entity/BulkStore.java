package com.gzport.meeting.domain.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by yushihui on 2018/11/28.
 */
@Entity
@Table(name = "BULK_STORE")
public class BulkStore {
    @Id
    @Column(name = "BULK_STORE_ID")
    private String bulkStoreId;
    @Column(name = "TER_CODE")
    private String terCode;     //公司
    @Column(name = "TOTAL_STORE")
    private long totalStore;    //各公司库存
    @Column(name = "ORE_STORE")
    private long oreStore;      //矿石
    @Column(name = "COAL_STORE")
    private long coalStore;     //煤炭
    @Column(name = "FOOD_STORE")
    private long foodStore;     //粮食
    @Column(name = "STEEL_STORE")
    private long steelStore;    //钢材
    @Column(name = "CAR_STORE")
    private long carStore;      //汽车

    @Column(name = "BULK_COMMENT")
    private String bulkComment;      //备注

    @Column(name = "INS_ACCOUNT")
    private String insAccount;
    @Column(name = "INS_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date insTimeStamp;
    @Column(name = "UPD_ACCOUNT")
    private String updAccount;
    @Column(name = "UPD_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updTimeStamp;

    public String getBulkStoreId() {
        return bulkStoreId;
    }

    public void setBulkStoreId(String bulkStoreId) {
        this.bulkStoreId = bulkStoreId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public long getTotalStore() {
        return totalStore;
    }

    public void setTotalStore(long totalStore) {
        this.totalStore = totalStore;
    }

    public long getOreStore() {
        return oreStore;
    }

    public void setOreStore(long oreStore) {
        this.oreStore = oreStore;
    }

    public long getCoalStore() {
        return coalStore;
    }

    public void setCoalStore(long coalStore) {
        this.coalStore = coalStore;
    }

    public long getFoodStore() {
        return foodStore;
    }

    public void setFoodStore(long foodStore) {
        this.foodStore = foodStore;
    }

    public long getSteelStore() {
        return steelStore;
    }

    public void setSteelStore(long steelStore) {
        this.steelStore = steelStore;
    }

    public long getCarStore() {
        return carStore;
    }

    public void setCarStore(long carStore) {
        this.carStore = carStore;
    }

    public String getBulkComment() {
        return bulkComment;
    }

    public void setBulkComment(String bulkComment) {
        this.bulkComment = bulkComment;
    }

    public String getInsAccount() {
        return insAccount;
    }

    public void setInsAccount(String insAccount) {
        this.insAccount = insAccount;
    }

    public Date getInsTimeStamp() {
        return insTimeStamp;
    }

    public void setInsTimeStamp(Date insTimeStamp) {
        this.insTimeStamp = insTimeStamp;
    }

    public String getUpdAccount() {
        return updAccount;
    }

    public void setUpdAccount(String updAccount) {
        this.updAccount = updAccount;
    }

    public Date getUpdTimeStamp() {
        return updTimeStamp;
    }

    public void setUpdTimeStamp(Date updTimeStamp) {
        this.updTimeStamp = updTimeStamp;
    }
}
