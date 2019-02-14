package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.entity.CarStore;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/17.
 */
public interface CarStoreRepository extends PagingAndSortingRepository<CarStore,String>{

    List<CarStore> findAllByTerCode(String terCode, Pageable pageable);

    @Modifying
    @Query(value = "SELECT t FROM CarStore t  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    List<CarStore> findCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM CarStore t  WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1 AND TER_CODE=?2")
    List<CarStore> findDataByTimeAndWharf(Date date, String terId);


    @Modifying
    @Query(value = "SELECT t FROM CarStore t  WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1")
    List<CarStore> findDataByTime(Date date);

    @Modifying
    @Query(value = "DELETE FROM CarStore  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date, String terId);
}
