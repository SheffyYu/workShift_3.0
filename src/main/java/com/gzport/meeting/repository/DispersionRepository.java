package com.gzport.meeting.repository;

import com.gzport.meeting.domain.entity.Dispersion;
import com.gzport.meeting.domain.entity.DispersionCargo;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/3.
 */
public interface DispersionRepository extends PagingAndSortingRepository<Dispersion,String>{

//    @Modifying
//    @Query(value = "",nativeQuery = true)
//    public List<Dispersion> findCurrentDataByWharf();

    Iterable<Dispersion> save(Iterable<? extends Dispersion> entities);

}
