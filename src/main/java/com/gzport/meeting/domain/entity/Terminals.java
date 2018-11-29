package com.gzport.meeting.domain.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.sql.Date;

/**
 * Created by zhangxiang on 2018/11/28.
 */

@Entity
@Table(name = "TERMINALS")
public class Terminals implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "TER_CODE")
    private String terCode;
    @Column(name = "TER_NAME")
    private String terName;
    @Column(name = "TER_TYPE")
    private String terType;
    @Column(name="TER_X")
    private Long terX;

    @Column(name="TER_Y")
    private Long terY;
    @Column(name="TER_LENGTH")
    private Long terLength;

    @Column(name="TER_SHORTNAME")
    private String terShortname;

    @Column(name="TER_COLOR")
    private String terColor;

    @Column(name="TER_GWJCODE")
    private String terGWJcode;

    @Column(name="TER_AREA")
    private String terArea;

    @Column(name="CAS_INSERTUSER")
    private String casInsertuser;

    @Column(name="CAS_INSERTDT")
    private Date casInsertdt;

    @Column(name="TER_LSTUPDDT")
    private Date terLstupddt;

    @Column(name="TER_LSUPDUSER")
    private String terLsupduser;

    @Column(name="CSA_REMARK")
    private String csaRemark;

    @Column(name="TER_ENAME")
    private String terEname;

    @Column(name="TER_PST_ID")
    private Long terPstId;

    @Column(name="TER_GW_ID")
    private String terGwId;

    @Column(name="TER_SOTRER")
    private Long terSorter;

    @Column(name="TER_BERTHNUM")
    private Long terBerthnum;

    @Column(name="TER_CARGO_WGT")
    private Long terCargoWgt;

    @Column(name="TER_CNTR_WGT")
    private Long terCntrWgt;

    @Column(name="TER_VEHICLE_WGT")
    private Long terVehicleWgt;

    @Column(name="TER_PASS_WGT")
    private Long terPassWgt;

    @Column(name="TER_ISVIEW")
    private String terIsview;

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public String getTerName() {
        return terName;
    }

    public void setTerName(String terName) {
        this.terName = terName;
    }

    public String getTerType() {
        return terType;
    }

    public void setTerType(String terType) {
        this.terType = terType;
    }

    public Long getTerX() {
        return terX;
    }

    public void setTerX(Long terX) {
        this.terX = terX;
    }

    public Long getTerY() {
        return terY;
    }

    public void setTerY(Long terY) {
        this.terY = terY;
    }

    public Long getTerLength() {
        return terLength;
    }

    public void setTerLength(Long terLength) {
        this.terLength = terLength;
    }

    public String getTerShortname() {
        return terShortname;
    }

    public void setTerShortname(String terShortname) {
        this.terShortname = terShortname;
    }

    public String getTerColor() {
        return terColor;
    }

    public void setTerColor(String terColor) {
        this.terColor = terColor;
    }

    public String getTerGWJcode() {
        return terGWJcode;
    }

    public void setTerGWJcode(String terGWJcode) {
        this.terGWJcode = terGWJcode;
    }

    public String getTerArea() {
        return terArea;
    }

    public void setTerArea(String terArea) {
        this.terArea = terArea;
    }

    public String getCasInsertuser() {
        return casInsertuser;
    }

    public void setCasInsertuser(String casInsertuser) {
        this.casInsertuser = casInsertuser;
    }

    public Date getCasInsertdt() {
        return casInsertdt;
    }

    public void setCasInsertdt(Date casInsertdt) {
        this.casInsertdt = casInsertdt;
    }

    public Date getTerLstupddt() {
        return terLstupddt;
    }

    public void setTerLstupddt(Date terLstupddt) {
        this.terLstupddt = terLstupddt;
    }

    public String getTerLsupduser() {
        return terLsupduser;
    }

    public void setTerLsupduser(String terLsupduser) {
        this.terLsupduser = terLsupduser;
    }

    public String getCsaRemark() {
        return csaRemark;
    }

    public void setCsaRemark(String csaRemark) {
        this.csaRemark = csaRemark;
    }

    public String getTerEname() {
        return terEname;
    }

    public void setTerEname(String terEname) {
        this.terEname = terEname;
    }

    public Long getTerPstId() {
        return terPstId;
    }

    public void setTerPstId(Long terPstId) {
        this.terPstId = terPstId;
    }

    public String getTerGwId() {
        return terGwId;
    }

    public void setTerGwId(String terGwId) {
        this.terGwId = terGwId;
    }

    public Long getTerSorter() {
        return terSorter;
    }

    public void setTerSorter(Long terSorter) {
        this.terSorter = terSorter;
    }

    public Long getTerBerthnum() {
        return terBerthnum;
    }

    public void setTerBerthnum(Long terBerthnum) {
        this.terBerthnum = terBerthnum;
    }

    public Long getTerCargoWgt() {
        return terCargoWgt;
    }

    public void setTerCargoWgt(Long terCargoWgt) {
        this.terCargoWgt = terCargoWgt;
    }

    public Long getTerCntrWgt() {
        return terCntrWgt;
    }

    public void setTerCntrWgt(Long terCntrWgt) {
        this.terCntrWgt = terCntrWgt;
    }

    public Long getTerVehicleWgt() {
        return terVehicleWgt;
    }

    public void setTerVehicleWgt(Long terVehicleWgt) {
        this.terVehicleWgt = terVehicleWgt;
    }

    public Long getTerPassWgt() {
        return terPassWgt;
    }

    public void setTerPassWgt(Long terPassWgt) {
        this.terPassWgt = terPassWgt;
    }

    public String getTerIsview() {
        return terIsview;
    }

    public void setTerIsview(String terIsview) {
        this.terIsview = terIsview;
    }


}
