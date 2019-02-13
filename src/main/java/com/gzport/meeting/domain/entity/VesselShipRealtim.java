package com.gzport.meeting.domain.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by yushihui on 2019/2/12.
 */
@Entity
@Table(name="VESSEL_SHIP_REALTIM")
public class VesselShipRealtim {
    @Id
    @Column(name="VBTID")
    private Long vbtId;

    @Column(name="BERTREAL")
    private String bertreal;

    @Column(name="VSLNATIONALTY")
    private String vslnationalty;

    @Column(name="VSLNAME")
    private String vslname;

    @Column(name="TOPORT")
    private String toport;

    @Column(name="VCL_PARRIVALTM")
    @Temporal(TemporalType.TIMESTAMP)
    private Date vcl_parrivaltm;

    @Column(name="STARTTIMEI")
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttimei;

    @Column(name="STARTTIMEE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date starttimee;

    @Column(name="VBT_COMEJOB")
    private String vbt_comejob;

    @Column(name="GMTNAME")
    private String gmtname;

    @Column(name="GMTNAMEI")
    private String gmtnamei;

    @Column(name="GMTNAMEE")
    private String gmtnamee;

    @Column(name="TYPES")
    private String types;

    @Column(name="VWKPENDTM")
    @Temporal(TemporalType.TIMESTAMP)
    private Date vwkpendtm;

    @Column(name="VWKASTARTTM")
    @Temporal(TemporalType.TIMESTAMP)
    private Date vwkastarttm;

    @Column(name="VWKAENDTM")
    @Temporal(TemporalType.TIMESTAMP)
    private Date vwkaendtm;

    @Column(name="FULFILTIMEI")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fulfiltimei;

    @Column(name="FULFILTIMEE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fulfiltimee;

    @Column(name="BERTHTIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date berthtime;

    @Column(name="LEAVETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date leavetime;

    @Column(name="PLANMESSAGE")
    private String planmessage;

    @Column(name="SUMNUMI")
    private String sumnumi;

    @Column(name="SUMNUME")
    private String sumnume;

    @Column(name="LEAVENUMI")
    private Float leavenumi;

    @Column(name="LEAVENUME")
    private Float leavenume;

    @Column(name="AWORKI")
    private String aworki;

    @Column(name="AWORKE")
    private String aworke;

    @Column(name="PORTCOMP")
    private String portcomp;

    @Column(name="EFFECT")
    private String effect;

    @Column(name="WORKPACE")
    private Float workpace;

    @Column(name="ISCASH")
    private String iscash;

    @Column(name="VBT_PBERTHTM")
    @Temporal(TemporalType.TIMESTAMP)
    private Date vbt_pberthtm;

    @Column(name="VBT_PLEAVETM")
    @Temporal(TemporalType.TIMESTAMP)
    private Date vbt_pleavetm;

    public Long getVbtId() {
        return vbtId;
    }

    public void setVbtId(Long vbtId) {
        this.vbtId = vbtId;
    }

    public String getBertreal() {
        return bertreal;
    }

    public void setBertreal(String bertreal) {
        this.bertreal = bertreal;
    }

    public String getVslnationalty() {
        return vslnationalty;
    }

    public void setVslnationalty(String vslnationalty) {
        this.vslnationalty = vslnationalty;
    }

    public String getVslname() {
        return vslname;
    }

    public void setVslname(String vslname) {
        this.vslname = vslname;
    }

    public String getToport() {
        return toport;
    }

    public void setToport(String toport) {
        this.toport = toport;
    }

    public Date getVcl_parrivaltm() {
        return vcl_parrivaltm;
    }

    public void setVcl_parrivaltm(Date vcl_parrivaltm) {
        this.vcl_parrivaltm = vcl_parrivaltm;
    }

    public Date getStarttimei() {
        return starttimei;
    }

    public void setStarttimei(Date starttimei) {
        this.starttimei = starttimei;
    }

    public Date getStarttimee() {
        return starttimee;
    }

    public void setStarttimee(Date starttimee) {
        this.starttimee = starttimee;
    }

    public String getVbt_comejob() {
        return vbt_comejob;
    }

    public void setVbt_comejob(String vbt_comejob) {
        this.vbt_comejob = vbt_comejob;
    }

    public String getGmtname() {
        return gmtname;
    }

    public void setGmtname(String gmtname) {
        this.gmtname = gmtname;
    }

    public String getGmtnamei() {
        return gmtnamei;
    }

    public void setGmtnamei(String gmtnamei) {
        this.gmtnamei = gmtnamei;
    }

    public String getGmtnamee() {
        return gmtnamee;
    }

    public void setGmtnamee(String gmtnamee) {
        this.gmtnamee = gmtnamee;
    }

    public String getTypes() {
        return types;
    }

    public void setTypes(String types) {
        this.types = types;
    }

    public Date getVwkpendtm() {
        return vwkpendtm;
    }

    public void setVwkpendtm(Date vwkpendtm) {
        this.vwkpendtm = vwkpendtm;
    }

    public Date getVwkastarttm() {
        return vwkastarttm;
    }

    public void setVwkastarttm(Date vwkastarttm) {
        this.vwkastarttm = vwkastarttm;
    }

    public Date getVwkaendtm() {
        return vwkaendtm;
    }

    public void setVwkaendtm(Date vwkaendtm) {
        this.vwkaendtm = vwkaendtm;
    }

    public Date getFulfiltimei() {
        return fulfiltimei;
    }

    public void setFulfiltimei(Date fulfiltimei) {
        this.fulfiltimei = fulfiltimei;
    }

    public Date getFulfiltimee() {
        return fulfiltimee;
    }

    public void setFulfiltimee(Date fulfiltimee) {
        this.fulfiltimee = fulfiltimee;
    }

    public Date getBerthtime() {
        return berthtime;
    }

    public void setBerthtime(Date berthtime) {
        this.berthtime = berthtime;
    }

    public Date getLeavetime() {
        return leavetime;
    }

    public void setLeavetime(Date leavetime) {
        this.leavetime = leavetime;
    }

    public String getPlanmessage() {
        return planmessage;
    }

    public void setPlanmessage(String planmessage) {
        this.planmessage = planmessage;
    }

    public String getSumnumi() {
        return sumnumi;
    }

    public void setSumnumi(String sumnumi) {
        this.sumnumi = sumnumi;
    }

    public String getSumnume() {
        return sumnume;
    }

    public void setSumnume(String sumnume) {
        this.sumnume = sumnume;
    }

    public Float getLeavenumi() {
        return leavenumi;
    }

    public void setLeavenumi(Float leavenumi) {
        this.leavenumi = leavenumi;
    }

    public Float getLeavenume() {
        return leavenume;
    }

    public void setLeavenume(Float leavenume) {
        this.leavenume = leavenume;
    }

    public String getAworki() {
        return aworki;
    }

    public void setAworki(String aworki) {
        this.aworki = aworki;
    }

    public String getAworke() {
        return aworke;
    }

    public void setAworke(String aworke) {
        this.aworke = aworke;
    }

    public String getPortcomp() {
        return portcomp;
    }

    public void setPortcomp(String portcomp) {
        this.portcomp = portcomp;
    }

    public String getEffect() {
        return effect;
    }

    public void setEffect(String effect) {
        this.effect = effect;
    }

    public Float getWorkpace() {
        return workpace;
    }

    public void setWorkpace(Float workpace) {
        this.workpace = workpace;
    }

    public String getIscash() {
        return iscash;
    }

    public void setIscash(String iscash) {
        this.iscash = iscash;
    }

    public Date getVbt_pberthtm() {
        return vbt_pberthtm;
    }

    public void setVbt_pberthtm(Date vbt_pberthtm) {
        this.vbt_pberthtm = vbt_pberthtm;
    }

    public Date getVbt_pleavetm() {
        return vbt_pleavetm;
    }

    public void setVbt_pleavetm(Date vbt_pleavetm) {
        this.vbt_pleavetm = vbt_pleavetm;
    }
}
