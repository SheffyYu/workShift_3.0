package com.gzport.meeting.domain.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by zhangxiang on 2019/1/30.
 */
@Entity
@Table(name="VESSELS")
public class Vessels implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="VSL_ID")
    private Long vslId;

    @Column(name="VSL_NAME")
    private String vslName;

    @Column(name="VSL_TYPE")
    private String vslType;

    @Column(name="VSL_LENGTH")
    private String vslLength;

    @Column(name="VSL_WIDTH")
    private String vslWidth;

    @Column(name="VSL_HEIGHT")
    private String vslHeight;

    @Column(name="VSL_LOADTON")
    private BigDecimal vslLoadton;

    @Column(name="VSL_TOTALWEIGHT")
    private String vslTotalweight;

    @Column(name="VSL_MAXSEAGAUGE")
    private String vslMaxseagauge;

    @Column(name="VSL_NATIONALITY")
    private String vslNationality;



    public Long getVslId() {
        return vslId;
    }

    public void setVslId(Long vslId) {
        this.vslId = vslId;
    }

    public String getVslName() {
        return vslName;
    }

    public void setVslName(String vslName) {
        this.vslName = vslName;
    }

    public String getVslType() {
        return vslType;
    }

    public void setVslType(String vslType) {
        this.vslType = vslType;
    }

    public String getVslLength() {
        return vslLength;
    }

    public void setVslLength(String vslLength) {
        this.vslLength = vslLength;
    }

    public String getVslWidth() {
        return vslWidth;
    }

    public void setVslWidth(String vslWidth) {
        this.vslWidth = vslWidth;
    }

    public String getVslHeight() {
        return vslHeight;
    }

    public void setVslHeight(String vslHeight) {
        this.vslHeight = vslHeight;
    }

    public BigDecimal getVslLoadton() {
        return vslLoadton;
    }

    public void setVslLoadton(BigDecimal vslLoadton) {
        this.vslLoadton = vslLoadton;
    }

    public String getVslTotalweight() {
        return vslTotalweight;
    }

    public void setVslTotalweight(String vslTotalweight) {
        this.vslTotalweight = vslTotalweight;
    }

    public String getVslMaxseagauge() {
        return vslMaxseagauge;
    }

    public void setVslMaxseagauge(String vslMaxseagauge) {
        this.vslMaxseagauge = vslMaxseagauge;
    }

    public String getVslNationality() {
        return vslNationality;
    }

    public void setVslNationality(String vslNationality) {
        this.vslNationality = vslNationality;
    }
}
