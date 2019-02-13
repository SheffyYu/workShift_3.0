package com.gzport.meeting.domain.vo;

/**
 * Created by zhangxiang on 2019/2/12.
 */
public class CntrDetatilVO {
    private String statue;
    private Long cntrN0umber;

    public CntrDetatilVO() {
    }

    public CntrDetatilVO(String statue, Long cntrN0umber) {
        this.statue = statue;
        this.cntrN0umber = cntrN0umber;
    }

    public String getStatue() {
        return statue;
    }

    public void setStatue(String statue) {
        this.statue = statue;
    }

    public Long getCntrN0umber() {
        return cntrN0umber;
    }

    public void setCntrN0umber(Long cntrN0umber) {
        this.cntrN0umber = cntrN0umber;
    }
}
