package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Throughput;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2018/12/10.
 */
public interface ThroughputRepository extends PagingAndSortingRepository<Throughput,String> {
    @Modifying
    @Query(value = "SELECT * FROM THROUGHPUT  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd')",nativeQuery = true)
    public Throughput findByDate(String date);
}
