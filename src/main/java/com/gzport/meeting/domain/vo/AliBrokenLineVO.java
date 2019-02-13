package com.gzport.meeting.domain.vo;

import java.sql.Date;

/**
 * Created by zhangxiang on 2019/2/12.
 */
public class AliBrokenLineVO {
    private String total;
    private Date time;

    public AliBrokenLineVO() {
    }

    public AliBrokenLineVO(String total, java.util.Date time) {
        this.total = total;
        this.time = new java.sql.Date(time.getTime());
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
