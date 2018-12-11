package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.domain.vo.BulkStoreVO;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/5.
 */
public interface BulkStoreService {
    BulkStore save(BulkStore barge);
    Iterable<BulkStore> saveAll(Iterable<BulkStore> barges);
    List<BulkStore> getBulkByTime(String time);
    List<BulkStore> getCurrentBulkByTerId(String terId);
    List<BulkStoreVO> getBulkStoreVOByTime(String time);
    void deleteCurrentBargeByTerId(String terId);
}
