package com.outside.outel.Util;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Version: 1.0
 * @Date: 2020/12/28 上午 09:10
 * @ClassName: Tools
 * @Author: Stapx Steve
 * @Description TODO 其他工具
 **/
public class Tools {

    /**
     * @Author Stapx Steve
     * @Description TODO 验证字符串是否存在特殊字符
     * @Date 下午 01:25 2020/12/26
     * @Param [str]
     * @return boolean
     **/
    public static boolean isSpecialChar(String str) {
        String regEx = "[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]|\n|\r|\t";
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(str);
        return m.find();
    }

    /**
     * @Author Stapx Steve
     * @Description TODO 验证邮箱正确性
     * @Date 下午 01:25 2020/12/26
     * @Param [email]
     * @return boolean
     **/
    public static boolean checkEmail(String email) {
        boolean flag = false;
        try {
            String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
            Pattern regex = Pattern.compile(check);
            Matcher matcher = regex.matcher(email);
            flag = matcher.matches();
        } catch (Exception e) {
            flag = false;
        }
        return flag;
    }

    /**
     * @Author Stapx Steve
     * @Description TODO 获取连接在一起的8位时间
     * @Date 下午 03:56 2020/12/29
     * @Param [addDay]
     * @return java.lang.String
    **/
    public static String GetDayString(int addDay) {
        Calendar now = Calendar.getInstance();
        now.setTime(new Date());
        now.set(Calendar.DATE, now.get(Calendar.DATE) + addDay);
        SimpleDateFormat sdf =   new SimpleDateFormat( " yyyyMMdd" );
        return sdf.format(now.getTime());
    }


}
