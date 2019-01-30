package com.gzport.meeting.domain.entity;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.stereotype.Controller;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by zhangxiang on 2019/1/29.
 */
@Entity
@Table(name="ANCHORAGE_WORK")
public class AnchorageWork implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name = "ANCHORAGE_WORK_ID")
    private String anchorageWorkId;

    //船名
    @Column(name="VSL_NAME")
    private String vslNmae;

    //船国籍
    @Column(name="VSL_NATIONALITY")
    private String valNationality;

    //船舶种类
    @Column(name="VSL_TYPE")
    private String vslType;

    //总吨
    @Column(name="VSL_TOTALWEIGHT")
    private BigDecimal vslTotalweight;

    //船长
    @Column(name="VSL_LENGTH")
    private BigDecimal vslLength;

    //船宽
    @Column(name="VSL_WIDTH")
    private BigDecimal vslWidth;

    //载重吨
    @Column(name="VSL_LOADTON")
    private Long vslLoadton;

    //锚地代码
    @Column(name="ANCHORAGE_CODE")
    private String anchorageCode;

    //满载吃水
    @Column(name="VSL_MAXSEAGAUGE")
    private String vslMaxseagauge;

    //tpc
    @Column(name="SHIP_TPC")
    private BigDecimal shipTpc;

    //货物名称
    @Column(name="GOODS_NAME")
    private String goodsName;

    //货物数量
    @Column(name="GOODS_NUMBER")
    private Long goodsNumber;

    //过驳数量
    @Column(name="TRANS_NUMBER")
    private Long transNumber;

   //作业方式
    @Column(name="WORK_TYPE")
    private String workType;

    //锚泊开始时间
    @Column(name="BERTHSTARTTIM")
    private Date berthstarttim;

    //锚泊结束时间
    @Column(name="BERTHENDTIM")
    private Date berthendtim;

    //收货人
    @Column(name="CONSIGNEE")
    private String confignee;

    //预计离港时间
    @Column(name="PRELEAVETIM")
    private String preleavetim;

    //作业机器形式
    @Column(name="WAY_WORK")
    private String wayWork;

    //作业船舶名
    @Column(name="WORK_SHIPNAM")
    private String workShipnam;

    public String getAnchorageWorkId() {
        return anchorageWorkId;
    }

    public void setAnchorageWorkId(String anchorageWorkId) {
        this.anchorageWorkId = anchorageWorkId;
    }

    public String getVslNmae() {
        return vslNmae;
    }

    public void setVslNmae(String vslNmae) {
        this.vslNmae = vslNmae;
    }

    public String getValNationality() {
        return valNationality;
    }

    public void setValNationality(String valNationality) {
        this.valNationality = valNationality;
    }

    public String getVslType() {
        return vslType;
    }

    public void setVslType(String vslType) {
        this.vslType = vslType;
    }

    public BigDecimal getVslTotalweight() {
        return vslTotalweight;
    }

    public void setVslTotalweight(BigDecimal vslTotalweight) {
        this.vslTotalweight = vslTotalweight;
    }

    public BigDecimal getVslLength() {
        return vslLength;
    }

    public void setVslLength(BigDecimal vslLength) {
        this.vslLength = vslLength;
    }

    public BigDecimal getVslWidth() {
        return vslWidth;
    }

    public void setVslWidth(BigDecimal vslWidth) {
        this.vslWidth = vslWidth;
    }

    public Long getVslLoadton() {
        return vslLoadton;
    }

    public void setVslLoadton(Long vslLoadton) {
        this.vslLoadton = vslLoadton;
    }

    public String getAnchorageCode() {
        return anchorageCode;
    }

    public void setAnchorageCode(String anchorageCode) {
        this.anchorageCode = anchorageCode;
    }

    public String getVslMaxseagauge() {
        return vslMaxseagauge;
    }

    public void setVslMaxseagauge(String vslMaxseagauge) {
        this.vslMaxseagauge = vslMaxseagauge;
    }

    public BigDecimal getShipTpc() {
        return shipTpc;
    }

    public void setShipTpc(BigDecimal shipTpc) {
        this.shipTpc = shipTpc;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public Long getGoodsNumber() {
        return goodsNumber;
    }

    public void setGoodsNumber(Long goodsNumber) {
        this.goodsNumber = goodsNumber;
    }

    public Long getTransNumber() {
        return transNumber;
    }

    public void setTransNumber(Long transNumber) {
        this.transNumber = transNumber;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public Date getBerthstarttim() {
        return berthstarttim;
    }

    public void setBerthstarttim(Date berthstarttim) {
        this.berthstarttim = berthstarttim;
    }

    public Date getBerthendtim() {
        return berthendtim;
    }

    public void setBerthendtim(Date berthendtim) {
        this.berthendtim = berthendtim;
    }

    public String getConfignee() {
        return confignee;
    }

    public void setConfignee(String confignee) {
        this.confignee = confignee;
    }

    public String getPreleavetim() {
        return preleavetim;
    }

    public void setPreleavetim(String preleavetim) {
        this.preleavetim = preleavetim;
    }

    public String getWayWork() {
        return wayWork;
    }

    public void setWayWork(String wayWork) {
        this.wayWork = wayWork;
    }

    public String getWorkShipnam() {
        return workShipnam;
    }

    public void setWorkShipnam(String workShipnam) {
        this.workShipnam = workShipnam;
    }
}
