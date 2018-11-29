package com.gzport.meeting.domain.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by yushihui on 2018/11/29.
 */
@Entity
@Table(name = "ROLES")
public class Roles {
    @Id
    @Column(name = "ROLE_ID")
    private String roleId;
}
