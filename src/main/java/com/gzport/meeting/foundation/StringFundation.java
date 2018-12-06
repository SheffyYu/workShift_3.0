package com.gzport.meeting.foundation;

/**
 * Created by zhangxiang on 2018/12/6.
 */
public class StringFundation {

    //判断是否为数字
    public static boolean isNumber(String str){
        String reg = "^[0-9]+(.[0-9]+)?$";
        return str.matches(reg);
    }
}
