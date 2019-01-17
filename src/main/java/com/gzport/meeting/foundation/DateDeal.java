package com.gzport.meeting.foundation;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by zhangxiang on 2019/1/2.
 */
public class DateDeal {
    public static Long getMins(Date endDate, Date nowDate) {

        long nd = 1000 * 24 * 60 * 60;
        long nh = 1000 * 60 * 60;
        long nm = 1000 * 60;
        // long ns = 1000;
        // 获得两个时间的毫秒时间差异
        long diff = endDate.getTime() - nowDate.getTime();
        // 计算差多少天
        long day = diff / nd;
        // 计算差多少小时
        long hour = diff % nd / nh;
        // 计算差多少分钟
        long min = diff % nd % nh / nm;
        // 计算差多少秒//输出结果
        // long sec = diff % nd % nh % nm / ns;
        return diff/nm;
    }

    public static Date getSpecifiedDayAfter(Date currentDate){
        Calendar c = Calendar.getInstance();
        String  specifiedDay=new SimpleDateFormat("yy-MM-dd").format(currentDate);
        Date date=null;
        try {
            date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        c.setTime(date);
        int day=c.get(Calendar.DATE);
        c.set(Calendar.DATE,day+1);
        String dayAfter=new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
        Date afterDate=null;
        try {
            afterDate=new SimpleDateFormat("yy-MM-dd").parse(dayAfter);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return afterDate;
    }

    public static Date  getSpecifiedDayBefore(Date currentDate){
        Calendar c = Calendar.getInstance();
        String  specifiedDay=new SimpleDateFormat("yy-MM-dd").format(currentDate);
        Date date=null;
        try {
            date = new SimpleDateFormat("yy-MM-dd").parse(specifiedDay);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        c.setTime(date);
        int day=c.get(Calendar.DATE);
        c.set(Calendar.DATE,day-1);
        String dayAfter=new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
        Date afterDate=null;
        try {
            afterDate=new SimpleDateFormat("yy-MM-dd").parse(dayAfter);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return afterDate;
    }

    public static Date DateConvert(String date){
        try {
            if((new SimpleDateFormat("yyyy-MM-dd").format(new Date())).equals(date))
                return null;
            Date time = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return time;
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
}
