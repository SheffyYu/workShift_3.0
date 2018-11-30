package com.gzport.meeting.repository.hdrepository;

import com.gzport.meeting.domain.entity.Menu;
import net.huadong.idev.hdmessagecode.HdMessageCode;
import net.huadong.tech.springboot.core.HdEzuiDatagridData;
import net.huadong.tech.springboot.core.HdEzuiQueryParams;
import net.huadong.tech.springboot.core.HdEzuiSaveDatagridData;
import net.huadong.tech.springboot.core.repository.HdAbstractRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceContextType;
import javax.transaction.Transactional;

/**
 * Created by zhangxiang on 2018/11/30.
 */
@Repository
public class HDMenuRepository extends HdAbstractRepository<Menu> {
    @PersistenceContext(type = PersistenceContextType.EXTENDED)
    EntityManager em;

    public HDMenuRepository() {
        super(Menu.class);
    }

    @Override
    protected EntityManager getEntityManager() {
        return this.em;
    }

    @Transactional
    public HdMessageCode ezuiSave(HdEzuiSaveDatagridData<Menu> hdEzuiSaveDatagridData) {
        return super.save(hdEzuiSaveDatagridData);
    }

    public HdEzuiDatagridData ezuiFind(HdEzuiQueryParams hdEzuiQueryParams) {
        return super.ezuiFind(hdEzuiQueryParams);
    }
}
