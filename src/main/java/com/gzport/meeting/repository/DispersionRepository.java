package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.DispersionCargo;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import java.util.Date;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.Iterator;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/3.
 */
public interface DispersionRepository extends PagingAndSortingRepository<Dispersion,String>{

    @Modifying
    @Query(value = "SELECT t FROM Dispersion t  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    List<Dispersion> findCurrentDataByWharf(Date date,String terId);

    @Modifying
    @Query(value = "SELECT t FROM Dispersion t  WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1 AND TER_CODE=?2")
    List<Dispersion> findDataByTimeAndWharf(Date date,String terId);

    @Modifying
    @Query(value = "DELETE FROM Dispersion  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date,String terId);

}
