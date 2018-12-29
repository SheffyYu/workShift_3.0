package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.DailyTerdataLog;
import com.gzport.meeting.repository.DailyTerDataLogRepository;
import com.gzport.meeting.service.DailyTerDataLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.constraints.Size;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/28.
 */
@Service
public class DailyTerDataLogServiceImpl implements DailyTerDataLogService {

    @Autowired
    DailyTerDataLogRepository dailyTerDataLogRepository;

    @Override
    public DailyTerdataLog updateStatus(DailyTerdataLog dailyTerdataLog) {
        return dailyTerDataLogRepository.save(dailyTerdataLog);
    }

    @Override
    public List<DailyTerdataLog> findDataByStatus(String status) {
        return dailyTerDataLogRepository.findByStatus(status);
    }

    @Override
    public DailyTerdataLog findByTerCodeAndStatus(String terCode, String status) {
        return dailyTerDataLogRepository.findAllByTerCodeAndStatus(terCode,status);
    }
}
