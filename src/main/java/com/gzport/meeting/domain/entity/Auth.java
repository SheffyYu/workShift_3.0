package com.gzport.meeting.domain.entity;

import org.eclipse.persistence.annotations.UuidGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * Created by yushihui on 2018/11/29.
 */
@Entity
@Table(name = "AUTH")
public class Auth {
    @Id
    @NotNull
    @Size(min = 1, max = 36)
    @Column(name = "USER_ID")
    private String userId;

    @Column(name = "ACCOUNT")
    private String account;     //账号
    @Column(name = "NAME")
    private String name;        //用户名称
    @Column(name = "PASSWORD")
    private String password;    //密码
    @Column(name = "DESCRIPTION")
    private String description;    //描述

    @Column(name = "INS_ACCOUNT")
    private String insAccount;
    @Column(name = "INS_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date insTimeStamp;
    @Column(name = "UPD_ACCOUNT")
    private String updAccount;
    @Column(name = "UPD_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updTimeStamp;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getInsAccount() {
        return insAccount;
    }

    public void setInsAccount(String insAccount) {
        this.insAccount = insAccount;
    }

    public Date getInsTimeStamp() {
        return insTimeStamp;
    }

    public void setInsTimeStamp(Date insTimeStamp) {
        this.insTimeStamp = insTimeStamp;
    }

    public String getUpdAccount() {
        return updAccount;
    }

    public void setUpdAccount(String updAccount) {
        this.updAccount = updAccount;
    }

    public Date getUpdTimeStamp() {
        return updTimeStamp;
    }

    public void setUpdTimeStamp(Date updTimeStamp) {
        this.updTimeStamp = updTimeStamp;
    }
}
