package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.Attendence;
import com.gzport.meeting.repository.AttendenceRepository;
import com.gzport.meeting.service.AttendenceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/1/18.
 */
@Service
public class AttendenceServiceImpl implements AttendenceService {

    @Autowired
    AttendenceRepository attendenceRepository;

    @Override
    public Attendence save(Attendence attendence) {
        return attendenceRepository.save(attendence);
    }

    @Override
    public Iterable<Attendence> saveAll(Iterable<Attendence> attendences) {
        return attendenceRepository.saveAll(attendences);
    }

    @Override
    public List<Attendence> findCurrentByWharf(String terCode) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try{
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return attendenceRepository.findCurrentDataByWharf(time,terCode);
        }catch (ParseException e){
            return null;
        }
    }


    @Override
    public List<Attendence> findAttendenceByWharfAndTime(String terId, String date) {
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return attendenceRepository.findCurrentDataByWharf(time,terId);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Attendence> findAttendenceByDate(Date date) {
        return attendenceRepository.findDataByDate(date);
    }

    @Transactional
    @Override
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            attendenceRepository.deleteCurrentDataByWharf(time,terId);
        }catch (ParseException e){

        }
    }
}
