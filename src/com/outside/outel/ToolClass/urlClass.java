package com.outside.outel.ToolClass;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;

/**
 * @Version: 1.0
 * @Date: 2020/12/25 下午 09:30
 * @ClassName: urlClass
 * @Author: Stapxs
 * @Description TO DO
 **/
public class urlClass {
    public static String urlEncode(String str) throws UnsupportedEncodingException {
        StringBuilder sb = new StringBuilder();
        //获得UTF-8编码的字节数组
        byte[] utf8 = str.getBytes("UTF-8");
        for (byte b : utf8) {
            System.out.println(b);
            //将字节转换成16进制，并截取最后两位
            String hexStr = Integer.toHexString(b);
            String temp = hexStr.substring(hexStr.length() - 2);
            //添加%
            sb.append("%");
            sb.append(temp);
        }
        return sb.toString();
    }

    public static String urlDecode(String str) throws UnsupportedEncodingException {
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
            System.out.println(temp);
            //转换成自字节
            arr[i / 3] = (byte) Integer.parseInt(temp, 16);
        }
        System.out.println(Arrays.toString(arr));    //[-28, -72, -83, -27, -101, -67]
        //解码
        return new String(arr, 0, arr.length, "UTF-8");
    }

}
