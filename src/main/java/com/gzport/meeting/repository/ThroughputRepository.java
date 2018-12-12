package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Throughput;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/10.
 */
public interface ThroughputRepository extends PagingAndSortingRepository<Throughput,String> {
    @Modifying
    @Query(value = "SELECT * FROM THROUGHPUT  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd')",nativeQuery = true)
    List<Throughput> findByDate(String date);

    @Modifying
    @Query(value = "DELETE FROM THROUGHPUT  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd')",nativeQuery = true)
    void deleteByDate(String date);
}
