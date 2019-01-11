package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.entity.Terminals;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import org.springframework.data.jpa.domain.Specification;
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
    @Query(value = "SELECT t FROM BulkStore t  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    List<BulkStore> findCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM BulkStore t  WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1")
    List<BulkStore> findBulkBytime(Date date);

    @Modifying
    @Query(value = "SELECT NEW com.gzport.meeting.domain.vo.BulkStoreVO(t1.bulkStoreId,t1.terCode,t2.terShortname,t1.totalStore,t1.oreStore,t1.coalStore,t1.foodStore,t1.steelStore,t1.carStore,t1.insTimeStamp,t1.insAccount,t1.updAccount,t1.updTimeStamp) FROM BulkStore t1 left join Terminals t2 on t1.terCode=t2.terCode where t1.insTimeStamp >=?1")
    List<BulkStoreVO> findBulkVOBytime(Date date);

    @Modifying
    @Query(value = "DELETE FROM BulkStore t  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date, String terId);

}
