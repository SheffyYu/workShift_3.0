package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.DispersionCargo;

/**
 * Created by zhangxiang on 2018/12/3.
 */

public interface DispersionCargoService {

    DispersionCargo save(DispersionCargo dispersionCargo);

    void delete(DispersionCargo dispersionCargo);

    DispersionCargo findByName(String name);

    DispersionCargo findByCargoCode(String cargoCode);


}
