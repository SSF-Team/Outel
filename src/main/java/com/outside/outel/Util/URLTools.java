package com.outside.outel.Util;

import java.io.UnsupportedEncodingException;

/**
 * @Version: 1.0
 * @Date: 2020/12/28 上午 09:11
 * @ClassName: URL
 * @Author: Stapx Steve
 * @Description TODO URL 相关
 **/
public class URLTools {

    /**
     * @Author Stapx Steve
     * @Description TODO URL 编码
     * @Date 上午 08:56 2020/12/28
     * @Param [str]
     * @return java.lang.String
     **/

    public static String Encode(String str) throws UnsupportedEncodingException {
        StringBuilder sb = new StringBuilder();
        //获得UTF-8编码的字节数组
        byte[] utf8 = str.getBytes("UTF-8");
        for (byte b : utf8) {
            //将字节转换成16进制，并截取最后两位
            String hexStr = Integer.toHexString(b);
            String temp = hexStr.substring(hexStr.length() - 2);
            //添加%
            sb.append("%");
            sb.append(temp);
        }
        return sb.toString();
    }

    /**
     * @Author Stapx Steve
     * @Description TODO URL 解码
     * @Date 上午 08:57 2020/12/28
     * @Param [str]
     * @return java.lang.String
     **/
    public static String Decode(String str) throws UnsupportedEncodingException {
        if (str == null) {
            return null;
        }
        if (str.length() % 3 != 0) {
            return null;
        }
        byte[] arr = new byte[str.length() / 3];
        for (int i = 0; i <= str.length() - 3; i += 3) {
            //截取%后两位
            String temp = null;
            if (i == str.length() - 3) {
                temp = str.substring(i + 1);
            } else {
                temp = str.substring(i + 1, i + 3);
            }
            //转换成自字节
            arr[i / 3] = (byte) Integer.parseInt(temp, 16);
        }
        //解码
        return new String(arr, 0, arr.length, "UTF-8");
    }

}
