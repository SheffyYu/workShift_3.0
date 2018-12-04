package com.gzport.meeting.domain.dto;


/**
 * Created by zhangxiang on 2018/12/4.
 */
public class AuthInfo {
    private String name;
    private String account;
    private String description;    //描述
    private String company; //公司


    public AuthInfo(String name,String account,String description,String company){
        this.name=name;
        this.description=description;
        this.account=account;
        this.company=company;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }
}
