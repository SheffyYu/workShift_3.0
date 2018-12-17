package com.gzport.meeting.domain.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/15.
 */
@Entity
@Table(name = "TERMINALS_DATE_LOG")
public class TerminalsDateLog  implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name = "ROLE_ID")
    private String TERMINALS_DATE_LOG_ID;

    @Column(name="TER_CODE")
    private String terCode;

    @Column(name = "INS_ACCOUNT")
    private String insAccount;
    @Column(name = "INS_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date insTimestamp;


    public String getTERMINALS_DATE_LOG_ID() {
        return TERMINALS_DATE_LOG_ID;
    }

    public void setTERMINALS_DATE_LOG_ID(String TERMINALS_DATE_LOG_ID) {
        this.TERMINALS_DATE_LOG_ID = TERMINALS_DATE_LOG_ID;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public String getInsAccount() {
        return insAccount;
    }

    public void setInsAccount(String insAccount) {
        this.insAccount = insAccount;
    }

    public Date getInsTimestamp() {
        return insTimestamp;
    }

    public void setInsTimestamp(Date insTimestamp) {
        this.insTimestamp = insTimestamp;
    }
}
