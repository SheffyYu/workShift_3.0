package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.vo.BulkStoreVO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/5.
 */
public interface BulkStoreService {
    BulkStore save(BulkStore barge);
    Iterable<BulkStore> saveAll(Iterable<BulkStore> barges);
    List<BulkStore> getBulkByTime(String time);
    List<BulkStore> getCurrentBulkByTerId(String terId);

    List<BulkStore> findBulkStoreByWharfAndTime(String terId,String date);

    List<BulkStoreVO> getBulkStoreVOByTime(Date time);
    List<BulkStore> getLastFiveDataByterCode(String terCode, Pageable pageable);
    void deleteCurrentBargeByTerId(String terId);

}
