package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.BulkStore;
import com.gzport.meeting.service.BulkStoreService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/5.
 */

@Service
public class BulkStoreServiceImpl implements BulkStoreService {
    @Override
    public BulkStore save(BulkStore barge) {
        return null;
    }

    @Override
    public Iterable<BulkStore> saveAll(Iterable<BulkStore> barges) {
        return null;
    }

    @Override
    public List<BulkStore> getCurrentBargeByTerId(String terId) {
        return null;
    }
}
