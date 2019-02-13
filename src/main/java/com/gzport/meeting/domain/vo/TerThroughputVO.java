package com.gzport.meeting.domain.vo;

import java.math.BigDecimal;

/**
 * Created by zhangxiang on 2019/2/12.
 */
public class TerThroughputVO {
    private BigDecimal monthlyPlan;

    private BigDecimal monthlyTotal;

    private BigDecimal monthlyPer;

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

    public BigDecimal getMonthlyPer() {
        return monthlyPer;
    }

    public void setMonthlyPer(BigDecimal monthlyPer) {
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
        this.monthlyPer = monthlyPer.setScale(0,BigDecimal.ROUND_HALF_UP);
        if(monthlyPer!=null)
            this.monthlyPro = this.monthlyPer.divide(BigDecimal.valueOf(100));
    }
}
