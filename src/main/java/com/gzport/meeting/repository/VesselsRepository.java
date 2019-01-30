package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Vessels;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2019/1/30.
 */
public interface VesselsRepository extends PagingAndSortingRepository<Vessels,Long> {
    Vessels findByVslName(String name);
}
