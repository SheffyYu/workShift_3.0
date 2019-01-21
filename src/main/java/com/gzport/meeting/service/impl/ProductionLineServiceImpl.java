package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.ProductionLine;
import com.gzport.meeting.repository.ProductionLineRepository;
import com.gzport.meeting.service.ProductionLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangxiang on 2018/12/4.
 */
@Service
public class ProductionLineServiceImpl implements ProductionLineService {

    @Autowired
    ProductionLineRepository productionLineRepository;

    @Override
    public ProductionLine save(ProductionLine productionLine) {
        return productionLineRepository.save(productionLine);
    }

    @Override
    public Iterable<ProductionLine> saveAll(Iterable<ProductionLine> productionLines) {
        return productionLineRepository.saveAll(productionLines);
    }

    @Override
    public List<ProductionLine> findCurrentProByTerID(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return productionLineRepository.findCurrentDataByWharf(time,terId);
        }catch (ParseException e){
            return null;
        }
    }

    @Override
    public List<ProductionLine> findProByTerIDAndTime(String terId,String date) {
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return productionLineRepository.findByTimeAndWharf(time,terId);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<ProductionLine> findProByDate(Date date) {
        return productionLineRepository.findByTime(date);
    }

    @Override
    @Transactional
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        try {
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            productionLineRepository.deleteCurrentDataByWharf(time,terId);
        }catch (ParseException e){
        }
    }
}
