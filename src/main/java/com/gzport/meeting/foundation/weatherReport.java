package com.gzport.meeting.foundation;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 描述：趴取网页上的今天的天气
 * @author     zjm
 * @time     2014/8/6
 */
public class weatherReport {

    /**
     * 发起http get请求获取网页源代码
     * @param requestUrl     String    请求地址
     * @return                 String    该地址返回的html字符串
     */
    private static String httpRequest(String requestUrl) {

        StringBuffer buffer = null;
        BufferedReader bufferedReader = null;
        InputStreamReader inputStreamReader = null;
        InputStream inputStream = null;
        HttpURLConnection httpUrlConn = null;

        try {
            // 建立get请求
            URL url = new URL(requestUrl);
            httpUrlConn = (HttpURLConnection) url.openConnection();
            httpUrlConn.setDoInput(true);
            httpUrlConn.setRequestMethod("GET");

            // 获取输入流
            inputStream = httpUrlConn.getInputStream();
            inputStreamReader = new InputStreamReader(inputStream, "utf-8");
            bufferedReader = new BufferedReader(inputStreamReader);

            // 从输入流读取结果
            buffer = new StringBuffer();
            String str = null;
            while ((str = bufferedReader.readLine()) != null) {
                buffer.append(str);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }  finally {
            // 释放资源
            if(bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(inputStreamReader != null){
                try {
                    inputStreamReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(inputStream != null){
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(httpUrlConn != null){
                httpUrlConn.disconnect();
            }
        }
        return buffer.toString();
    }

    /**
     * 过滤掉html字符串中无用的信息,广州市气象
     * @param html    String    html字符串
     * @return         String    有用的数据
     */
    private static String htmlFiterGuangzhou(String html) {

        StringBuffer buffer = new StringBuffer();
        String str1 = "";
        String str2 = "";

        // 取出有用的范围
        Pattern p = Pattern.compile("(.*)(<body>)(.*?)(</body>)(.*)");
        Matcher m = p.matcher(html);
        if (m.matches()) {
            str1 = m.group(3);
            // 匹配天气
            p = Pattern.compile("(.*)(今天下午到明天上午：)(.*?)(<br>)(.*)");
            m = p.matcher(str1);
            if(m.matches()){
                str2 = m.group(3);
                buffer.append(str2);
                buffer.append(",");
            }
            // 匹配气温
            p = Pattern.compile("(.*)(&nbsp; &nbsp; &nbsp; &nbsp;)(.*?)(<br>)(.*)");
            m = p.matcher(str1);
            if(m.matches()){
                str2 = m.group(3);
                buffer.append(str2);
                buffer.append(",");
            }
            // 匹配风向
            p = Pattern.compile("(.*)(&nbsp; &nbsp; &nbsp; &nbsp;)(.*?)(<br />&nbsp;)(.*)");
            m = p.matcher(str1);
            if(m.matches()){
                str2 = m.group(3);
                buffer.append(str2);
            }

        }
        return buffer.toString();
    }

    /**
     * 过滤掉html字符串中无用的信息,珠江
     * @param html    String    html字符串
     * @return         String    有用的数据
     */
    private static String htmlFiterZhuJiang(String html) {

        StringBuffer buffer = new StringBuffer();
        String str1 = "";

        // 取出有用的范围
        Pattern p = Pattern.compile("(.*)(<tr class=\"text_TR1\">)(.*?)(</tr>)(.*)");
        Matcher m = p.matcher(html);
        if (m.matches()) {
            str1 = m.group(3);
            // 匹配天气
            p = Pattern.compile("(<td[^>]*>[^<]*</td>)");
            m = p.matcher(str1);
            int count=0;
            while(m.find()){
                count+=1;
                if(count>1 && count<6){
                    Pattern tp = Pattern.compile("(.*)(<td>)(.*?)(</td>)(.*)");
                    Matcher tm = tp.matcher(m.group());
                    if (tm.matches()) {
                        str1 = tm.group(3);
                        buffer.append(str1);
                        switch (count){
                            case 2:
                                buffer.append(",吹");
                                break;
                            case 3:
                                buffer.append("风");
                                break;
                            case 4:
                                buffer.append("级，阵风");
                                break;
                            case 5:
                                buffer.append("级");
                                break;
                        }
                    }
                }
            }

        }
        return buffer.toString();
    }

    /**
     *  对以上两个方法进行封装。
     * @return
     */
    public static List<String> getTemperatureInfo() {
        List<String> list = new ArrayList<>();
        // 调用第一个方法，获取html字符串
        String html1 = httpRequest("http://www.gd12121.com:8080/special/Fcst/Gzfc.htm");
        // 调用第二个方法，过滤掉无用的信息
        String result1 = htmlFiterGuangzhou(html1);
        // 调用第一个方法，获取html字符串
        String html2 = httpRequest("http://www.gd12121.com:8080/special/fcst/zn.html");
        // 调用第二个方法，过滤掉无用的信息
        String result2 = htmlFiterZhuJiang(html2);
        list.add(result1);
        list.add(result2);

        return list;
    }
}
