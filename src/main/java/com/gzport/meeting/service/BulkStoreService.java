package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.BulkStore;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/5.
 */
public interface BulkStoreService {
    BulkStore save(BulkStore barge);
    Iterable<BulkStore> saveAll(Iterable<BulkStore> barges);
    List<BulkStore> getCurrentBargeByTerId(String terId);
}
