package com.gzport.meeting.domain.vo;

import java.math.BigDecimal;

/**
 * Created by zhangxiang on 2019/2/12.
 */
public class TerThroughputVO {
    private BigDecimal monthlyPlan;

    private BigDecimal monthlyTotal;

    private String monthlyPer;

    private BigDecimal monthlyPro;

    public BigDecimal getMonthlyPlan() {
        return monthlyPlan;
    }

    public void setMonthlyPlan(BigDecimal monthlyPlan) {
        this.monthlyPlan = monthlyPlan;
    }

    public BigDecimal getMonthlyTotal() {
        return monthlyTotal;
    }

    public void setMonthlyTotal(BigDecimal monthlyTotal) {
        this.monthlyTotal = monthlyTotal;
    }

    public String getMonthlyPer() {
        return monthlyPer;
    }

    public void setMonthlyPer(String monthlyPer) {
        this.monthlyPer = monthlyPer;
    }

    public BigDecimal getMonthlyPro() {
        return monthlyPro;
    }

    public void setMonthlyPro(BigDecimal monthlyPro) {
        this.monthlyPro = monthlyPro;
    }

    public TerThroughputVO() {
    }

    public TerThroughputVO(BigDecimal monthlyPlan, BigDecimal monthlyTotal, BigDecimal monthlyPer) {
        this.monthlyPlan = monthlyPlan;
        this.monthlyTotal = monthlyTotal;
        this.monthlyPer = monthlyPer.setScale(0,BigDecimal.ROUND_HALF_UP).toString()+"%";
        if(monthlyPer!=null)
            this.monthlyPro = monthlyPer.divide(BigDecimal.valueOf(100));
    }
}
