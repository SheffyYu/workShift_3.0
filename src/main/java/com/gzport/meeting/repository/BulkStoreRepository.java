package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.vo.BulkStoreVO;
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
    @Query(value = "SELECT  t1.BULK_STORE_ID,t1.TER_CODE,t1.TOTAL_STORE,t1.TOTAL_STORE,t1.ORE_STORE,t1.COAL_STORE,t1.FOOD_STORE,t1.STEEL_STORE,t1.CAR_STORE,\n" +
            "t2.TER_SHORTNAME FROM BULK_STORE t1 INNER JOIN TERMINALS t2 on t1.TER_CODE=t2.TER_CODE WHERE trunc(t1.INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd')",nativeQuery = true)
    public List<BulkStoreVO> findBulkVOBytime(String date);


    @Modifying
    @Query(value = "DELETE FROM BULK_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public void deleteCurrentDataByWharf(String date, String terId);
}
