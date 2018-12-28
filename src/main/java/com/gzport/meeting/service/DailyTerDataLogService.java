package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.DailyTerdataLog;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/28.
 */

public interface DailyTerDataLogService {

    DailyTerdataLog updateStatus(DailyTerdataLog dailyTerdataLog);

    List<DailyTerdataLog> findDataByStatus(String status);
}
