package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BulkStore;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/5.
 */
public interface BulkStoreRepository extends PagingAndSortingRepository<BulkStore,String> {

    @Modifying
    @Query(value = "SELECT * FROM BULK_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public List<BulkStore> findCurrentDataByWharf(String date, String terId);

    @Modifying
    @Query(value = "SELECT * FROM BULK_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd')",nativeQuery = true)
    public List<BulkStore> findBulkBytime(String date);

    @Modifying
    @Query(value = "DELETE FROM BULK_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public void deleteCurrentDataByWharf(String date, String terId);
}
