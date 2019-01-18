package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Attendence;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2019/1/18.
 */
public interface AttendenceRepository extends PagingAndSortingRepository<Attendence,String> {

    @Modifying
    @Query(value = "SELECT t FROM Attendence t  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    List<Attendence> findCurrentDataByWharf(Date date, String terId);

    @Modifying
    @Query(value = "SELECT t FROM Attendence t  WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1 AND TER_CODE=?2")
    List<Attendence> findDataByTimeAndWharf(Date date,String terId);

    @Modifying
    @Query(value = "SELECT t FROM Attendence t  WHERE INS_TIMESTAMP>=?1 AND INS_TIMESTAMP-1<?1")
    List<Attendence> findDataByDate(Date date);

    @Modifying
    @Query(value = "DELETE FROM Attendence  WHERE INS_TIMESTAMP>=?1 AND TER_CODE=?2")
    void deleteCurrentDataByWharf(Date date,String terId);

}
