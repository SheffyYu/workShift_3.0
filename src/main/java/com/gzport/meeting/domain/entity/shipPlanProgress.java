package com.gzport.meeting.domain.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/13.
 */
@Entity
@Table(name="SHIP_PLAN_PROGRESS")
public class shipPlanProgress  implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name="VBTID")
    private String vbtid;

    @Column(name="VBTBERTHBER")    //计划泊位
    private String vbtberthber;

    @Column(name="VSLNAME")     //船名
    private String vslname;

    @Column(name="GOODSINFO")       //货物信息
    private String goodsinfo;

    @Column(name="VBTPBERTHTM")     //计划靠泊
    @Temporal(TemporalType.TIMESTAMP)
    private Date vbtpERTHTM;

    @Column(name="VBTPLEAVETM")         //计划离泊
    @Temporal(TemporalType.TIMESTAMP)
    private Date vbtpleavetm;

    @Column(name="VBTABERHTTM")     //实际靠泊
    @Temporal(TemporalType.TIMESTAMP)
    private Date vbtaberhttm;

    @Column(name="VBTALEAVETM")     //实际离泊
    @Temporal(TemporalType.TIMESTAMP)
    private Date vbtaleavetm;

    @Column(name="STARTTIMEI")      //卸货开工时间
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttimei;

    @Column(name="FULFILTIMEI")     //卸货完工时间
    @Temporal(TemporalType.TIMESTAMP)
    private Date fulfiltimei;

    @Column(name="STARTTIMEE")      //装货开工时间
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttimee;

    @Column(name="FULFILTIMEE")     //装货完工时间
    @Temporal(TemporalType.TIMESTAMP)
    private Date fulfiltimee;

    @Column(name="STARTTIME")   //开工时间
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttime;

    @Column(name="OPER_EFF")        //效率
    private BigDecimal operEff;




    public String getVbtid() {
        return vbtid;
    }

    public void setVbtid(String vbtid) {
        this.vbtid = vbtid;
    }

    public String getVbtberthber() {
        return vbtberthber;
    }

    public void setVbtberthber(String vbtberthber) {
        this.vbtberthber = vbtberthber;
    }

    public String getVslname() {
        return vslname;
    }

    public void setVslname(String vslname) {
        this.vslname = vslname;
    }

    public String getGoodsinfo() {
        return goodsinfo;
    }

    public void setGoodsinfo(String goodsinfo) {
        this.goodsinfo = goodsinfo;
    }

    public Date getVbtpERTHTM() {
        return vbtpERTHTM;
    }

    public void setVbtpERTHTM(Date vbtpERTHTM) {
        this.vbtpERTHTM = vbtpERTHTM;
    }

    public Date getVbtpleavetm() {
        return vbtpleavetm;
    }

    public void setVbtpleavetm(Date vbtpleavetm) {
        this.vbtpleavetm = vbtpleavetm;
    }

    public Date getVbtaberhttm() {
        return vbtaberhttm;
    }

    public void setVbtaberhttm(Date vbtaberhttm) {
        this.vbtaberhttm = vbtaberhttm;
    }

    public Date getVbtaleavetm() {
        return vbtaleavetm;
    }

    public void setVbtaleavetm(Date vbtaleavetm) {
        this.vbtaleavetm = vbtaleavetm;
    }

    public Date getStarttimei() {
        return starttimei;
    }

    public void setStarttimei(Date starttimei) {
        this.starttimei = starttimei;
    }

    public Date getFulfiltimei() {
        return fulfiltimei;
    }

    public void setFulfiltimei(Date fulfiltimei) {
        this.fulfiltimei = fulfiltimei;
    }

    public Date getStarttimee() {
        return starttimee;
    }

    public void setStarttimee(Date starttimee) {
        this.starttimee = starttimee;
    }

    public Date getFulfiltimee() {
        return fulfiltimee;
    }

    public void setFulfiltimee(Date fulfiltimee) {
        this.fulfiltimee = fulfiltimee;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public BigDecimal getOperEff() {
        return operEff;
    }

    public void setOperEff(BigDecimal operEff) {
        this.operEff = operEff;
    }
}
