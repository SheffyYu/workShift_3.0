package com.gzport.meeting.domain.vo;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by yushihui on 2019/2/12.
 */
@JsonAutoDetect(fieldVisibility=JsonAutoDetect.Visibility.ANY, getterVisibility=JsonAutoDetect.Visibility.NONE)
public class ShipRealtmVO {

    private String BERTREAL;

    private String VSLNAME;

    private String VBT_COMEJOB;

    private String GMTNAME;

    private String SUMNUM;

    private String VWKASTARTTM;

    private String BERTHTIME;

    private String LEAVETIME;

    private String PORTCOMP;

    private String EFFECT;

    private String WORKPACE;

    private String ISCASH;

    private String VBT_PBERTHTM;

    private String VBT_PLEAVETM;

    public ShipRealtmVO(){}

    public ShipRealtmVO(String bertreal, String vslname, String vbt_comejob, String gmtname, String sumnumi, String sumnume, Date vwkastarttm, Date berthtime, Date leavetime, String portcomp, String effect, Float workpace, String iscash, Date vbt_pberthtm, Date vbt_pleavetm){
        if(bertreal != null){
            this.BERTREAL=bertreal;
        }else{
            this.BERTREAL="";
        }
        if (vslname != null){
            this.VSLNAME=vslname;
        }else{
            this.VSLNAME="";
        }
        if (vbt_comejob != null){
            this.VBT_COMEJOB=vbt_comejob;
        }else {
            this.VBT_COMEJOB="";
        }
        if(gmtname!=null){
            this.GMTNAME=gmtname;
        }else {
            this.GMTNAME="";
        }
        if (vbt_comejob.equals("卸")){
            if(sumnumi != null){
                this.SUMNUM=sumnumi;
            }else{
                this.SUMNUM="";
            }
        }else if (vbt_comejob.equals("装")){
            if(sumnume != null){
                this.SUMNUM=sumnume;
            }else{
                this.SUMNUM="";
            }
        }else {
            if(sumnume == null){
                sumnume="";
            }
            if(sumnumi == null){
                sumnumi="";
            }
            this.SUMNUM=sumnumi+'/'+sumnume;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd/hhmm");
        if (vwkastarttm != null){
            this.VWKASTARTTM=sdf.format(vwkastarttm);
        }else {
            this.VWKASTARTTM="";
        }
        if (berthtime != null){
            this.BERTHTIME=sdf.format(berthtime);
        }else {
            this.BERTHTIME="";
        }
        if (leavetime != null){
            this.LEAVETIME=sdf.format(leavetime);
        }else {
            this.LEAVETIME="";
        }
        this.PORTCOMP=portcomp;
        DecimalFormat fnum = new DecimalFormat("##0.00");
        if(effect != null){
            if(gmtname.contains("油")||gmtname.equals("汽车")||gmtname.equals("化工品")||gmtname.equals("集装箱")){
                this.EFFECT=fnum.format(Float.parseFloat(effect))+"/小时";
            }else{
                this.EFFECT=fnum.format(Float.parseFloat(effect)*24)+"/天";
            }
        }else{
            this.EFFECT="";
        }
        if(workpace != null){
            this.WORKPACE=fnum.format(workpace*100)+"%";
        }else{
            this.WORKPACE="";
        }
        if(iscash != null){
            if (iscash.equals("Y")){
                this.ISCASH="是";
            }else if(iscash.equals("N")){
                this.ISCASH="否";
            }else {
                this.ISCASH="";
            }
        }else {
            this.ISCASH="";
        }
        if(vbt_pberthtm != null ){
            this.VBT_PBERTHTM=sdf.format(vbt_pberthtm);
        }else {
            this.VBT_PBERTHTM="";
        }
        if(vbt_pleavetm != null ){
            this.VBT_PLEAVETM=sdf.format(vbt_pleavetm);
        }else {
            this.VBT_PLEAVETM="";
        }
    }

    public String getBERTREAL() {
        return BERTREAL;
    }

    public void setBERTREAL(String BERTREAL) {
        this.BERTREAL = BERTREAL;
    }

    public String getVSLNAME() {
        return VSLNAME;
    }

    public void setVSLNAME(String VSLNAME) {
        this.VSLNAME = VSLNAME;
    }

    public String getVBT_COMEJOB() {
        return VBT_COMEJOB;
    }

    public void setVBT_COMEJOB(String VBT_COMEJOB) {
        this.VBT_COMEJOB = VBT_COMEJOB;
    }

    public String getGMTNAME() {
        return GMTNAME;
    }

    public void setGMTNAME(String GMTNAME) {
        this.GMTNAME = GMTNAME;
    }

    public String getSUMNUM() {
        return SUMNUM;
    }

    public void setSUMNUM(String SUMNUM) {
        this.SUMNUM = SUMNUM;
    }

    public String getVWKASTARTTM() {
        return VWKASTARTTM;
    }

    public void setVWKASTARTTM(String VWKASTARTTM) {
        this.VWKASTARTTM = VWKASTARTTM;
    }

    public String getBERTHTIME() {
        return BERTHTIME;
    }

    public void setBERTHTIME(String BERTHTIME) {
        this.BERTHTIME = BERTHTIME;
    }

    public String getLEAVETIME() {
        return LEAVETIME;
    }

    public void setLEAVETIME(String LEAVETIME) {
        this.LEAVETIME = LEAVETIME;
    }

    public String getPORTCOMP() {
        return PORTCOMP;
    }

    public void setPORTCOMP(String PORTCOMP) {
        this.PORTCOMP = PORTCOMP;
    }

    public String getEFFECT() {
        return EFFECT;
    }

    public void setEFFECT(String EFFECT) {
        this.EFFECT = EFFECT;
    }

    public String getWORKPACE() {
        return WORKPACE;
    }

    public void setWORKPACE(String WORKPACE) {
        this.WORKPACE = WORKPACE;
    }

    public String getISCASH() {
        return ISCASH;
    }

    public void setISCASH(String ISCASH) {
        this.ISCASH = ISCASH;
    }

    public String getVBT_PBERTHTM() {
        return VBT_PBERTHTM;
    }

    public void setVBT_PBERTHTM(String VBT_PBERTHTM) {
        this.VBT_PBERTHTM = VBT_PBERTHTM;
    }

    public String getVBT_PLEAVETM() {
        return VBT_PLEAVETM;
    }

    public void setVBT_PLEAVETM(String VBT_PLEAVETM) {
        this.VBT_PLEAVETM = VBT_PLEAVETM;
    }
}
