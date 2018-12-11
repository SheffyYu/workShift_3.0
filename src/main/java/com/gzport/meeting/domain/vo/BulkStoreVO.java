package com.gzport.meeting.domain.vo;

import java.util.Date;
/**
 * Created by zhangxiang on 2018/12/10.
 */

public class BulkStoreVO {
    private String bulkStoreId;
    private String terCode;
    private String terShortname;
    private Float totalStore;
    private Float oreStore;
    private Float coalStore;
    private Float foodStore;
    private Float steelStore;
    private Float carStore;
    private Date insTimeStamp;
    private String insAccount;
    private String updAccount;
    private Date updTimestamp;


    public BulkStoreVO(String bulkStoreId, String terCode, String terShortname, Float totalStore, Float oreStore, Float coalStore, Float foodStore, Float steelStore, Float carStore, Date insTimeStamp, String insAccount, String updAccount, Date updTimestamp) {
        this.bulkStoreId = bulkStoreId;
        this.terCode = terCode;
        this.terShortname = terShortname;
        this.totalStore = totalStore;
        this.oreStore = oreStore;
        this.coalStore = coalStore;
        this.foodStore = foodStore;
        this.steelStore = steelStore;
        this.carStore = carStore;
        this.insTimeStamp = insTimeStamp;
        this.insAccount = insAccount;
        this.updAccount = updAccount;
        this.updTimestamp = updTimestamp;
    }

    public String getBulkStoreId() {
        return bulkStoreId;
    }

    public void setBulkStoreId(String bulkStoreId) {
        this.bulkStoreId = bulkStoreId;
    }

    public Date getInsTimeStamp() {
        return insTimeStamp;
    }

    public String getInsAccount() {
        return insAccount;
    }

    public void setInsAccount(String insAccount) {
        this.insAccount = insAccount;
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

    public void setInsTimeStamp(Date insTimeStamp) {
        this.insTimeStamp = insTimeStamp;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public String getTerShortname() {
        return terShortname;
    }

    public void setTerShortname(String terShortname) {
        this.terShortname = terShortname;
    }

    public Float getTotalStore() {
        return totalStore;
    }

    public void setTotalStore(Float totalStore) {
        this.totalStore = totalStore;
    }

    public Float getOreStore() {
        return oreStore;
    }

    public void setOreStore(Float oreStore) {
        this.oreStore = oreStore;
    }

    public Float getCoalStore() {
        return coalStore;
    }

    public void setCoalStore(Float coalStore) {
        this.coalStore = coalStore;
    }

    public Float getFoodStore() {
        return foodStore;
    }

    public void setFoodStore(Float foodStore) {
        this.foodStore = foodStore;
    }

    public Float getSteelStore() {
        return steelStore;
    }

    public void setSteelStore(Float steelStore) {
        this.steelStore = steelStore;
    }

    public Float getCarStore() {
        return carStore;
    }

    public void setCarStore(Float carStore) {
        this.carStore = carStore;
    }
}
