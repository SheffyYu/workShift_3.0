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
    @Query(value = "SELECT * FROM DISPERSION  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public List<Dispersion> findCurrentDataByWharf(String date,String terId);

    @Modifying
    @Query(value = "DELETE FROM DISPERSION  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public void deleteCurrentDataByWharf(String date,String terId);


}
