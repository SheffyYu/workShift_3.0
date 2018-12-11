package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.entity.Terminals;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Date;

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
    @Query(value = "SELECT NEW com.gzport.meeting.domain.vo.BulkStoreVO(t1.bulkStoreId,t1.terCode,t2.terShortname,t1.totalStore,t1.oreStore,t1.coalStore,t1.foodStore,t1.steelStore,t1.carStore,t1.insTimeStamp,t1.insAccount,t1.updAccount,t1.updTimeStamp) FROM BulkStore t1 left join Terminals t2 on t1.terCode=t2.terCode where t1.insTimeStamp >=?1")
    List<BulkStoreVO> findBulkVOBytime(Date date);

    @Modifying
    @Query(value = "DELETE FROM BULK_STORE  WHERE trunc(INS_TIMESTAMP)＝to_date(?1,'yyyy-mm-dd') AND TER_CODE=?2",nativeQuery = true)
    public void deleteCurrentDataByWharf(String date, String terId);
}
