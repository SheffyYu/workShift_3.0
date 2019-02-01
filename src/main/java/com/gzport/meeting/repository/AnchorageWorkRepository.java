package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.AnchorageWork;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2019/1/31.
 */
public interface AnchorageWorkRepository extends PagingAndSortingRepository<AnchorageWork,String> {
    AnchorageWork findByVslNmae(String shipName);
}
