package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BargeXS;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import java.util.Date;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface BargeXSRepository extends PagingAndSortingRepository<BargeXS,String> {
    @Modifying
    @Query(value = "SELECT t FROM BargeXS t WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    List<BargeXS> findCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM BargeXS t WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1 AND TER_CODE=?2")
    List<BargeXS> findByTimeAndWharf(Date date, String terId);

    @Modifying
    @Query(value = "DELETE FROM BargeXS  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date, String terId);
}
