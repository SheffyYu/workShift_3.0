package com.gzport.meeting.service.impl;

import com.gzport.meeting.domain.entity.ProductionLine;
import com.gzport.meeting.repository.ProductionLineRepository;
import com.gzport.meeting.service.ProductionLineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        return productionLineRepository.findCurrentDataByWharf(date,terId);
    }

    @Override
    public void deleteCurrentBargeByTerId(String terId) {
        String date=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        productionLineRepository.deleteCurrentDataByWharf(date,terId);
    }
}
