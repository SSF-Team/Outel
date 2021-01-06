package com.outside.outel.Service;

import com.outside.outel.Dao.User;

import java.sql.SQLException;

/**
 * @Version: 1.0
 * @Date: 2021/1/5 下午 03:10
 * @ClassName: LoginOut
 * @Author: Stapxs
 * @Description TO DO
 **/
public class LoginOut {

    public static String set(String id, String token) throws SQLException {
        String back = TokenPass.Verification(id, token);
        if(back.equals("OK")) {
            back = User.UpdateByID("token=''", id);
            if(back.equals("OK")) {
                return "OK";
            }
        }
        return "FAIL";
    }

}
