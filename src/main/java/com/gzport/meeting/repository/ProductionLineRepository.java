package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.ProductionLine;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface ProductionLineRepository extends PagingAndSortingRepository<ProductionLine,String> {
    @Modifying
    @Query(value = "SELECT * FROM PRODUCTION_LINE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2;",nativeQuery = true)
    public List<ProductionLine> findCurrentDataByWharf(String date, String terId);
}
