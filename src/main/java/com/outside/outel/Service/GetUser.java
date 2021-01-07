package com.outside.outel.Service;

import com.outside.outel.Dao.Dao;
import com.outside.outel.Layer.SQLConnecter;
import com.outside.outel.Util.Tools;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2021/1/4 上午 08:33
 * @ClassName: GetNewUser
 * @Author: Stapx Steve
 * @Description TODO 获取用户相关操作
 **/
public class GetUser {

    /**
     * @Author Stapx Steve
     * @Description TODO 获取最近五天内的新用户
     * @Date 上午 10:15 2021/1/4
     * @Param []
     * @return java.util.List<java.util.List<com.outside.outel.Dao.Dao.SQLVer>>
    **/
    public static List<List<Dao.SQLVer>> New() {
        List<List<Dao.SQLVer>> all = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT profile,user_name,reg_time,user_id from out_user;";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            ResultSet rs = stmt.executeQuery(sql);
            // 展开结果集数据库
            System.out.println("================> 检索最近注册");
            int get = 0;
            while(rs.next()){
                List<Dao.SQLVer> gets = new ArrayList<>();
                // 通过字段检索
                if(Integer.parseInt(rs.getString("reg_time").trim()) >= Integer.parseInt(Tools.GetDayString(-5).trim()) && get < 5) {
                    gets.add(new Dao.SQLVer("profile", rs.getString("profile")));
                    gets.add(new Dao.SQLVer("user_name", rs.getString("user_name")));
                    gets.add(new Dao.SQLVer("user_id", rs.getString("user_id")));
                    get ++;
                }
                all.add(gets);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return all;
    }

    public static List<List<Dao.SQLVer>> All() {
        List<List<Dao.SQLVer>> all = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT profile,user_name,reg_time,user_id from out_user;";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            ResultSet rs = stmt.executeQuery(sql);
            // 展开结果集数据库
            System.out.println("================> 检索所有用户");
            while(rs.next()){
                List<Dao.SQLVer> gets = new ArrayList<>();
                // 通过字段检索
                gets.add(new Dao.SQLVer("profile", rs.getString("profile")));
                gets.add(new Dao.SQLVer("user_name", rs.getString("user_name")));
                gets.add(new Dao.SQLVer("user_id", rs.getString("user_id")));
                all.add(gets);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return all;
    }
}
