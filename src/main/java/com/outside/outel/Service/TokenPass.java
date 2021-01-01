package com.outside.outel.Service;

import com.outside.outel.Dao.User;
import com.outside.outel.Layer.OptionReader;
import com.outside.outel.Util.Talk;
import com.outside.outel.Util.Tools;

import java.sql.SQLException;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2020/12/30 上午 10:13
 * @ClassName: TokenPass
 * @Author: Stapx Steve
 * @Description TODO 使用 Token 通过验证
 **/
public class TokenPass {

    public static String Verification(String id, String token) throws SQLException {
        // 获取 token
        List<User.SQLVer> infos = User.selectByID("token,token_dietime", id);
        System.out.println("================> 验证登录");
        String nowTime = Tools.GetDayString(0);
        int pass = 0;
        boolean get = false;
        for(User.SQLVer info: infos) {
            System.out.println("> " + info.name + " : " + info.value);
            get = true;
            if(info.name.equals("token") && info.value.equals(token)) {
                pass ++;
            }
            if(info.name.equals("token_dietime") && Integer.parseInt(info.value.trim()) > Integer.parseInt(nowTime.trim())) {
                pass ++;
            }
        }
        String back = "ERR";
        if(get) {
            switch (pass) {
                case 0: back = "FAIL"; break;
                case 1: back = "NO"; break;
                case 2: back = "OK"; break;
                default: back = "ERR"; break;
            }
        } else {
            back = "NULL";
        }
        System.out.println("Pass Finished：" + back);
        return back;
    }

}
