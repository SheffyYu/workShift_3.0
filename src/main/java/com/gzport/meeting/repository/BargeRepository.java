package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Barge;
import com.gzport.meeting.domain.entity.ProductionLine;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface BargeRepository extends PagingAndSortingRepository<Barge,String> {

    @Modifying
    @Query(value = "SELECT t FROM Barge t WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    List<Barge> findCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM Barge t WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1 AND TER_CODE=?2")
    List<Barge> findByTimeAndWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM Barge t WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1")
    List<Barge> findByTime(Date date);

    @Modifying
    @Query(value = "DELETE FROM Barge  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date, String terId);
}
