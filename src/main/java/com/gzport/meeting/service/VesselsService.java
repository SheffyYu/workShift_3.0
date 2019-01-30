package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Vessels;

/**
 * Created by zhangxiang on 2019/1/30.
 */
public interface VesselsService {

    Vessels save(Vessels vessels);

    Vessels find(String name);
}
