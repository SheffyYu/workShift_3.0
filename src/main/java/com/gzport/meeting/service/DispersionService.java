package com.gzport.meeting.service;

import com.gzport.meeting.domain.entity.Dispersion;

import java.util.List;

/**
 * Created by zhangxiang on 2018/12/3.
 */

public interface DispersionService {
    Dispersion save(Dispersion dispersion);
    Dispersion findCurrentDispersionByWharf(String terId);

    Iterable<Dispersion> saveInterable(Iterable<Dispersion> iterable);
}
