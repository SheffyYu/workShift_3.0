package com.gzport.meeting.domain.vo;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by yushihui on 2019/2/12.
 */
public class ShipRealtmVO {

    private String bertreal;

    private String vslname;

    private String vbt_comejob;

    private String gmtname;

    private String sumnum;

    private String vwkastarttm;

    private String berthtime;

    private String leavetime;

    private String portcomp;

    private String effect;

    private String workpace;

    private String iscash;

    private String vbt_pberthtm;

    private String vbt_pleavetm;

    public ShipRealtmVO(){}

    public ShipRealtmVO(String bertreal, String vslname, String vbt_comejob, String gmtname, String sumnumi, String sumnume, Date vwkastarttm, Date berthtime, Date leavetime, String portcomp, String effect, Float workpace, String iscash, Date vbt_pberthtm, Date vbt_pleavetm){
        if(bertreal != null){
            this.bertreal=bertreal;
        }else{
            this.bertreal="";
        }
        if (vslname != null){
            this.vslname=vslname;
        }else{
            this.vslname="";
        }
        if (vbt_comejob != null){
            this.vbt_comejob=vbt_comejob;
        }else {
            this.vbt_comejob="";
        }
        if(gmtname!=null){
            this.gmtname=gmtname;
        }else {
            this.gmtname="";
        }
        if (vbt_comejob.equals("卸")){
            if(sumnumi != null){
                this.sumnum=sumnumi;
            }else{
                this.sumnum="";
            }
        }else if (vbt_comejob.equals("装")){
            if(sumnume != null){
                this.sumnum=sumnume;
            }else{
                this.sumnum="";
            }
        }else {
            if(sumnume == null){
                sumnume="";
            }
            if(sumnumi == null){
                sumnumi="";
            }
            this.sumnum=sumnumi+'/'+sumnume;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd/hhmm");
        if (vwkastarttm != null){
            this.vwkastarttm=sdf.format(vwkastarttm);
        }else {
            this.vwkastarttm="";
        }
        if (berthtime != null){
            this.berthtime=sdf.format(berthtime);
        }else {
            this.berthtime="";
        }
        if (leavetime != null){
            this.leavetime=sdf.format(leavetime);
        }else {
            this.leavetime="";
        }
        this.portcomp=portcomp;
        DecimalFormat fnum = new DecimalFormat("##0.00");
        if(effect != null){
            if(gmtname.contains("油")||gmtname.equals("汽车")||gmtname.equals("化工品")||gmtname.equals("集装箱")){
                this.effect=fnum.format(Float.parseFloat(effect))+"/小时";
            }else{
                this.effect=fnum.format(Float.parseFloat(effect)*24)+"/天";
            }
        }else{
            this.effect="";
        }
        if(workpace != null){
            this.workpace=fnum.format(workpace*100)+"%";
        }else{
            this.workpace="";
        }
        if(iscash != null){
            if (iscash.equals("Y")){
                this.iscash="是";
            }else if(iscash.equals("N")){
                this.iscash="否";
            }else {
                this.iscash="";
            }
        }else {
            this.iscash="";
        }
        if(vbt_pberthtm != null ){
            this.vbt_pberthtm=sdf.format(vbt_pberthtm);
        }else {
            this.vbt_pberthtm="";
        }
        if(vbt_pleavetm != null ){
            this.vbt_pleavetm=sdf.format(vbt_pleavetm);
        }else {
            this.vbt_pleavetm="";
        }
    }

    public String getBertreal() {
        return bertreal;
    }

    public void setBertreal(String bertreal) {
        this.bertreal = bertreal;
    }

    public String getVslname() {
        return vslname;
    }

    public void setVslname(String vslname) {
        this.vslname = vslname;
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

    public String getSumnum() {
        return sumnum;
    }

    public void setSumnum(String sumnum) {
        this.sumnum = sumnum;
    }

    public String getVwkastarttm() {
        return vwkastarttm;
    }

    public void setVwkastarttm(String vwkastarttm) {
        this.vwkastarttm = vwkastarttm;
    }

    public String getBerthtime() {
        return berthtime;
    }

    public void setBerthtime(String berthtime) {
        this.berthtime = berthtime;
    }

    public String getLeavetime() {
        return leavetime;
    }

    public void setLeavetime(String leavetime) {
        this.leavetime = leavetime;
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

    public String getWorkpace() {
        return workpace;
    }

    public void setWorkpace(String workpace) {
        this.workpace = workpace;
    }

    public String getIscash() {
        return iscash;
    }

    public void setIscash(String iscash) {
        this.iscash = iscash;
    }

    public String getVbt_pberthtm() {
        return vbt_pberthtm;
    }

    public void setVbt_pberthtm(String vbt_pberthtm) {
        this.vbt_pberthtm = vbt_pberthtm;
    }

    public String getVbt_pleavetm() {
        return vbt_pleavetm;
    }

    public void setVbt_pleavetm(String vbt_pleavetm) {
        this.vbt_pleavetm = vbt_pleavetm;
    }
}
