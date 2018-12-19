package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.entity.TerThroughput;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/19.
 */
public interface TerThroughputRepository extends PagingAndSortingRepository<TerThroughput,String> {

    @Modifying
    @Query(value = "SELECT t FROM TerThroughput t  WHERE INS_TIMESTAMP>?1 AND TER_CODE=?2")
    List<TerThroughput> findCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM TerThroughput t  WHERE INS_TIMESTAMP>?1")
    List<TerThroughput> findTerThroughputBytime(Date date);

    @Modifying
    @Query(value = "DELETE FROM TerThroughput t  WHERE INS_TIMESTAMP>?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "DELETE FROM TerThroughput t  WHERE INS_TIMESTAMP>?1")
    void deleteTerThroughputByDate(Date date);

}
