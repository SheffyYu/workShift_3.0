package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Attendence;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2019/1/18.
 */
public interface AttendenceService {

    Attendence save(Attendence attendence);

    Iterable<Attendence> saveAll(Iterable<Attendence> attendences);

    List<Attendence> findCurrentByWharf(String terCode);
    List<Attendence> findAttendenceByWharfAndTime(String terId,String date);
    List<Attendence> findAttendenceByDate(Date date);
    void deleteCurrentBargeByTerId(String terId);
}
