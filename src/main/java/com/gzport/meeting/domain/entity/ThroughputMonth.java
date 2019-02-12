package com.gzport.meeting.domain.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Created by zhangxiang on 2019/2/1.
 */
@Entity
@Table(name="VJ_THROUGHPUT_MONTH")
public class ThroughputMonth implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="INS_DATE")
    private String insDate;

    @Column(name="TH_CARGO_TOTAL")
    private BigDecimal thCargoTotal;

    @Column(name="TH_CNTR_TOTAL")
    private BigDecimal thCntrTotal;

    public String getInsDate() {
        return insDate;
    }

    public void setInsDate(String insDate) {
        this.insDate = insDate;
    }

    public BigDecimal getThCargoTotal() {
        return thCargoTotal;
    }

    public void setThCargoTotal(BigDecimal thCargoTotal) {
        this.thCargoTotal = thCargoTotal;
    }

    public BigDecimal getThCntrTotal() {
        return thCntrTotal;
    }

    public void setThCntrTotal(BigDecimal thCntrTotal) {
        this.thCntrTotal = thCntrTotal;
    }
}
