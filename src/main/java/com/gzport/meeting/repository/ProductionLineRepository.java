package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.ProductionLine;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface ProductionLineRepository extends PagingAndSortingRepository<ProductionLine,String> {
    @Modifying
    @Query(value = "SELECT t FROM ProductionLine t WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    List<ProductionLine> findCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM ProductionLine t WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1 AND TER_CODE=?2")
    List<ProductionLine> findByTimeAndWharf(Date date, String terId);

    @Modifying
    @Query(value = "DELETE FROM ProductionLine  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date, String terId);
}
