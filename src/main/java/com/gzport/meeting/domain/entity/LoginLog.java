package com.gzport.meeting.domain.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by yushihui on 2018/11/28.
 */
@Entity
@Table(name = "LOGIN_LOG")
public class LoginLog {
    @Id
    @Column(name = "LOG_ID")
    private String logId;
    @Column(name = "USER_ID")
    private String userId;      //用户id
    @Column(name = "IP")
    private String ip;          //用户登录IP
    @Column(name = "INS_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date insTimestamp;  //登录时间

    public String getLogId() {
        return logId;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Date getInsTimestamp() {
        return insTimestamp;
    }

    public void setInsTimestamp(Date insTimestamp) {
        this.insTimestamp = insTimestamp;
    }
}
