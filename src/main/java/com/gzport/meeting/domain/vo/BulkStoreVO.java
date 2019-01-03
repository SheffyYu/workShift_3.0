package com.gzport.meeting.domain.vo;

import java.math.BigDecimal;
import java.util.Date;
/**
 * Created by zhangxiang on 2018/12/10.
 */

public class BulkStoreVO {
    private String bulkStoreId;
    private String terCode;
    private String terShortname;
    private BigDecimal totalStore;
    private BigDecimal oreStore;
    private BigDecimal coalStore;
    private BigDecimal foodStore;
    private BigDecimal steelStore;
    private BigDecimal carStore;
    private Date insTimestamp;
    private String insAccount;
    private String updAccount;
    private Date updTimestamp;

    public BulkStoreVO(){

    }

    public BulkStoreVO(String bulkStoreId, String terCode, String terShortname, BigDecimal totalStore, BigDecimal oreStore, BigDecimal coalStore, BigDecimal foodStore, BigDecimal steelStore, BigDecimal carStore, Date insTimestamp, String insAccount, String updAccount, Date updTimestamp) {
        this.bulkStoreId = bulkStoreId;
        this.terCode = terCode;
        this.terShortname = terShortname;
        this.totalStore = totalStore;
        this.oreStore = oreStore;
        this.coalStore = coalStore;
        this.foodStore = foodStore;
        this.steelStore = steelStore;
        this.carStore = carStore;
        this.insTimestamp = insTimestamp;
        this.insAccount = insAccount;
        this.updAccount = updAccount;
        this.updTimestamp = updTimestamp;
    }

    public Date getInsTimestamp() {
        return insTimestamp;
    }

    public void setInsTimestamp(Date insTimestamp) {
        this.insTimestamp = insTimestamp;
    }

    public String getBulkStoreId() {
        return bulkStoreId;
    }

    public void setBulkStoreId(String bulkStoreId) {
        this.bulkStoreId = bulkStoreId;
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

    public BigDecimal getTotalStore() {
        return totalStore;
    }

    public void setTotalStore(BigDecimal totalStore) {
        this.totalStore = totalStore;
    }

    public BigDecimal getOreStore() {
        return oreStore;
    }

    public void setOreStore(BigDecimal oreStore) {
        this.oreStore = oreStore;
    }

    public BigDecimal getCoalStore() {
        return coalStore;
    }

    public void setCoalStore(BigDecimal coalStore) {
        this.coalStore = coalStore;
    }

    public BigDecimal getFoodStore() {
        return foodStore;
    }

    public void setFoodStore(BigDecimal foodStore) {
        this.foodStore = foodStore;
    }

    public BigDecimal getSteelStore() {
        return steelStore;
    }

    public void setSteelStore(BigDecimal steelStore) {
        this.steelStore = steelStore;
    }

    public BigDecimal getCarStore() {
        return carStore;
    }

    public void setCarStore(BigDecimal carStore) {
        this.carStore = carStore;
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
}
