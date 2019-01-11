package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Throughput;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/10.
 */
public interface ThroughputRepository extends PagingAndSortingRepository<Throughput,String> {
    @Modifying
    @Query(value = "SELECT t FROM Throughput t WHERE INS_TIMESTAMP>=?1")
    List<Throughput> findByDate(Date date);

    @Modifying
    @Query(value = "DELETE FROM Throughput  WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1")
    void deleteByDate(Date date);
}
