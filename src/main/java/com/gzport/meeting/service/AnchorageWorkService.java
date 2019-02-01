package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.AnchorageWork;

/**
 * Created by zhangxiang on 2019/1/31.
 */
public interface AnchorageWorkService {
    AnchorageWork save(AnchorageWork anchorageWork);
    AnchorageWork findByShipName(String shipName);
}
