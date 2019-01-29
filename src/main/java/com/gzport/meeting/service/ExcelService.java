package com.gzport.meeting.service;

import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Created by zhangxiang on 2019/1/28.
 */
public interface ExcelService {

    void dataToExcel(String time) throws IOException;
}
