package com.outside.outel.ToolClass;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author Stapx Steve
 * @Description TODO 工具
 * @Date 下午 01:12 2020/12/26
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

}
