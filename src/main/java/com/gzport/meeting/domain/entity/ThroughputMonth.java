package com.gzport.meeting.domain.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

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
    private String thCargoTotal;

    @Column(name="TH_CNTR_TOTAL")
    private String thCntrTotal;

    public String getInsDate() {
        return insDate;
    }

    public void setInsDate(String insDate) {
        this.insDate = insDate;
    }

    public String getThCargoTotal() {
        return thCargoTotal;
    }

    public void setThCargoTotal(String thCargoTotal) {
        this.thCargoTotal = thCargoTotal;
    }

    public String getThCntrTotal() {
        return thCntrTotal;
    }

    public void setThCntrTotal(String thCntrTotal) {
        this.thCntrTotal = thCntrTotal;
    }
}
