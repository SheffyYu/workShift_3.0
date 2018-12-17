package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.entity.CarStore;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/17.
 */
public interface CarStoreRepository extends PagingAndSortingRepository<CarStore,String>{

    @Modifying
    @Query(value = "SELECT * FROM CAR_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    List<CarStore> findCurrentDataByWharf(String date, String terId);

    @Modifying
    @Query(value = "DELETE FROM CAR_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    void deleteCurrentDataByWharf(String date, String terId);
}
