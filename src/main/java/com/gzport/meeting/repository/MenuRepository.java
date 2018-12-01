package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Menu;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by zhangxiang on 2018/11/30.
 */
public interface MenuRepository extends PagingAndSortingRepository<Menu,String> {
}
