package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Barge;
import com.gzport.meeting.domain.entity.ProductionLine;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface BargeRepository extends PagingAndSortingRepository<Barge,String> {

    @Modifying
    @Query(value = "SELECT * FROM BARGE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public List<Barge> findCurrentDataByWharf(String date, String terId);
}
