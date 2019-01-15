package com.gzport.meeting.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 * Created by zhangxiang on 2019/1/15.
 */
@RestController
@RequestMapping("/login/export")
public class ExportController {

    @RequestMapping("/Excel")
    public void downLoadExcel(HttpServletResponse response) throws FileNotFoundException, UnsupportedEncodingException {
        File file_2 = new File("/files/jiaoban.xls");
        String fileName = new String("交接班记录表".getBytes("GBK"), "ISO-8859-1");
        OutputStream os = new FileOutputStream(file_2);
        if (file_2.length() > 0) {
            response.setContentType("application/force-download");
            response.setHeader("Content-disposition", "attachment; filename=" + fileName);
            byte[] buffer = new byte[1024];
            FileInputStream fis = null;
            BufferedInputStream bis = null;
            try {
                fis = new FileInputStream(file_2);
                bis = new BufferedInputStream(fis);
                OutputStream os2 = response.getOutputStream();
                int i = bis.read(buffer);
                while (i != -1) {
                    os2.write(buffer, 0, i);
                    i = bis.read(buffer);
                }
                System.out.println("success");
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
