package com.gzport.meeting.domain.vo;

/**
 * Created by zhangxiang on 2018/12/10.
 */

public class BulkStoreVO {
    private String terCode;
    private String terShortname;
    private Float totalStore;
    private Float oreStore;
    private Float coalStore;
    private Float foodStore;
    private Float steelStore;
    private Float carStore;

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
