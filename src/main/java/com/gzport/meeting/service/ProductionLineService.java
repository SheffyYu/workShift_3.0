package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.ProductionLine;

import java.util.List;
import java.util.Date;

/**
 * Created by zhangxiang on 2018/12/4.
 */
public interface ProductionLineService {

    ProductionLine save(ProductionLine productionLine);

    Iterable<ProductionLine> saveAll(Iterable<ProductionLine> productionLines);

    List<ProductionLine> findCurrentProByTerID(String terId);
    List<ProductionLine> findProByTerIDAndTime(String terId,String date);
    List<ProductionLine> findProByDate(Date date);

    void deleteCurrentBargeByTerId(String terId);

}
