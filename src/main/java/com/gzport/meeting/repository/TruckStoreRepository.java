package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.ProductionLine;
import com.gzport.meeting.domain.entity.TruckStore;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface TruckStoreRepository extends PagingAndSortingRepository<TruckStore,String>{
    @Modifying
    @Query(value = "SELECT * FROM TRUCK_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public List<TruckStore> findCurrentDataByWharf(String date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM TruckStore t WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1 AND TER_CODE=?2")
    List<TruckStore> findByDateAndTerCode(Date date, String terId);


    @Modifying
    @Query(value = "DELETE FROM TRUCK_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public void deleteCurrentDataByWharf(String date, String terId);

}
