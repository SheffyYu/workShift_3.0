package com.gzport.meeting.domain.vo;

import com.gzport.meeting.domain.entity.ThroughputMonth;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhangxiang on 2019/2/1.
 */
public class ThroughputMonthVO {

    private String insDate;

    private String number;

    private String status;

    public ThroughputMonthVO(){

    }

    public ThroughputMonthVO(String insDate, String number, String status) {
        this.insDate = insDate;
        this.number = number;
        this.status = status;
    }

    public String getInsDate() {
        return insDate;
    }

    public void setInsDate(String insDate) {
        this.insDate = insDate;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<ThroughputMonthVO> convertToThroughputVO(List<ThroughputMonth> throughputMonthList){
        List<ThroughputMonthVO> throughputMonthVOList=new ArrayList<>();
        for (int i=0;i<throughputMonthList.size();i++){
            ThroughputMonthVO throughputMonthVO=new ThroughputMonthVO(throughputMonthList.get(i).getInsDate(),throughputMonthList.get(i).getThCargoTotal(),"1");
            throughputMonthVOList.add(throughputMonthVO);
            throughputMonthVO=new ThroughputMonthVO(throughputMonthList.get(i).getInsDate(),throughputMonthList.get(i).getThCntrTotal(),"2");
            throughputMonthVOList.add(throughputMonthVO);
        }
        return throughputMonthVOList;
    }
}
