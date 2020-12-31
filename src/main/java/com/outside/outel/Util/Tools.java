package com.outside.outel.Util;

import Decoder.BASE64Decoder;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
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
     * @Author Stapxs
     * @Description TODO 将 Base64 图片保存为文件 From https://www.cnblogs.com/buguge/p/12177895.html
     * @Date 下午 10:36 2020/12/26
     * @Param [fileBase64String, filePath, fileName]
     * @return java.io.File
     **/
    public static File convertBase64ToFile(String fileBase64String, String filePath, String fileName) {

        BufferedOutputStream bos = null;
        FileOutputStream fos = null;
        File file = null;
        try {
            File dir = new File(filePath);
            if (!dir.exists() && dir.isDirectory()) {//判断文件目录是否存在
                dir.mkdirs();
            }

            BASE64Decoder decoder = new BASE64Decoder();
            byte[] bfile = decoder.decodeBuffer(fileBase64String);

            file = new File(filePath + File.separator + fileName);
            fos = new FileOutputStream(file);
            bos = new BufferedOutputStream(fos);
            bos.write(bfile);
            return file;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (bos != null) {
                try {
                    bos.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
            if (fos != null) {
                try {
                    fos.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
            }
        }
    }

    /**
     * @Author Stapxs
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
