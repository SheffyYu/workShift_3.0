package com.gzport.meeting.domain.entity;

import org.eclipse.persistence.annotations.UuidGenerator;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by yushihui on 2018/11/28.
 */
@Entity
@Table(name = "BULK_STORE")
public class BulkStore implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Size(min = 1, max = 36)
    @GeneratedValue(generator="system-uuid")
    @GenericGenerator(name="system-uuid", strategy = "uuid")
    @Column(name = "BULK_STORE_ID")
    private String bulkStoreId;
    @Column(name = "TER_CODE")
    private String terCode;     //公司
    @Column(name = "TOTAL_STORE")
    private Long totalStore;    //各公司库存
    @Column(name = "ORE_STORE")
    private Long oreStore;      //矿石
    @Column(name = "COAL_STORE")
    private Long coalStore;     //煤炭
    @Column(name = "FOOD_STORE")
    private Long foodStore;     //粮食
    @Column(name = "STEEL_STORE")
    private Long steelStore;    //钢材
    @Column(name = "CAR_STORE")
    private Long carStore;      //汽车

    @Column(name = "BULK_COMMENT")
    private String bulkComment;      //备注

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


    public String getBulkStoreId() {
        return bulkStoreId;
    }

    public void setBulkStoreId(String bulkStoreId) {
        this.bulkStoreId = bulkStoreId;
    }

    public String getTerCode() {
        return terCode;
    }

    public void setTerCode(String terCode) {
        this.terCode = terCode;
    }

    public Long getTotalStore() {
        return totalStore;
    }

    public void setTotalStore(Long totalStore) {
        this.totalStore = totalStore;
    }

    public Long getOreStore() {
        return oreStore;
    }

    public void setOreStore(Long oreStore) {
        this.oreStore = oreStore;
    }

    public Long getCoalStore() {
        return coalStore;
    }

    public void setCoalStore(Long coalStore) {
        this.coalStore = coalStore;
    }

    public Long getFoodStore() {
        return foodStore;
    }

    public void setFoodStore(Long foodStore) {
        this.foodStore = foodStore;
    }

    public Long getSteelStore() {
        return steelStore;
    }

    public void setSteelStore(Long steelStore) {
        this.steelStore = steelStore;
    }

    public Long getCarStore() {
        return carStore;
    }

    public void setCarStore(Long carStore) {
        this.carStore = carStore;
    }

    public String getBulkComment() {
        return bulkComment;
    }

    public void setBulkComment(String bulkComment) {
        this.bulkComment = bulkComment;
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

    @PrePersist
    protected void prePersist(){
        if(this.insTimeStamp == null){
            insTimeStamp= new Date();
        }
        if(this.updTimeStamp == null){
            updTimeStamp=new Date();
        }
    }

    @PreUpdate
    protected void preUpdate(){
        this.updTimeStamp=new Date();
    }
}
