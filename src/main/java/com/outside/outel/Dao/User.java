package com.outside.outel.Dao;

import com.outside.outel.Layer.SQLConnecter;
import com.outside.outel.Dao.Dao;
import java.nio.charset.StandardCharsets;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2020/12/28 上午 09:29
 * @ClassName: User
 * @Author: Stapx Steve
 * @Description TODO out_user 表相关操作（User 相关操作）
 **/
public class User {

    public static List<Dao.SQLVer> selectByMail(String what, String mail) {
        List<Dao.SQLVer> info = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT " + what + " from out_user WHERE email = '" + mail + "';";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            ResultSet rs = stmt.executeQuery(sql);
            // 展开结果集数据库
            while(rs.next()){
                // 通过字段检索
                String[] names = what.split(",");
                for(String name: names) {
                    String get = rs.getString(name);
                    info.add(new Dao.SQLVer(name, get));
                }
            }
        } catch (Throwable th) {
            info.add(new Dao.SQLVer("ERR", th.toString()));
            return info;
        }
        info.add(new Dao.SQLVer("ERR", "UNKNOWN"));
        return info;
    }

    public static List<Dao.SQLVer> selectByID(String what, String id) {
        List<Dao.SQLVer> info = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT " + what + " from out_user WHERE user_id = " + id + ";";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            ResultSet rs = stmt.executeQuery(sql);
            // 展开结果集数据库
            while(rs.next()){
                // 通过字段检索
                String[] names = what.split(",");
                for(String name: names) {
                    String get = rs.getString(name);
                    info.add(new Dao.SQLVer(name, get));
                }
            }
        } catch (Throwable th) {
            info.add(new Dao.SQLVer("ERR", th.toString()));
            return info;
        }
        info.add(new Dao.SQLVer("ERR", "UNKNOWN"));
        return info;
    }

    public static List<Dao.SQLVer> selectAll(String what) {
        List<Dao.SQLVer> info = new ArrayList<>();
        if(what.contains(",")) {
            info.add(new Dao.SQLVer("ERR", "selectAll ONLY ONE"));
            return info;
        }
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT " + what + " from out_user;";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            ResultSet rs = stmt.executeQuery(sql);
            // 展开结果集数据库
            while(rs.next()){
                // 通过字段检索
                String get = rs.getString(what);
                info.add(new Dao.SQLVer(what, get));
            }
        } catch (Throwable th) {
            info.add(new Dao.SQLVer("ERR", th.toString()));
            return info;
        }
        info.add(new Dao.SQLVer("ERR", "UNKNOWN"));
        return info;
    }

    public static String UpdateByMail(String what, String mail) {
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "UPDATE out_user SET " + what + " WHERE email = '" + mail + "';";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            int back = stmt.executeUpdate(sql);
            if(back == 1) {
                return "OK";
            } else {
                return "操作失败！";
            }
        } catch (Throwable th) {
            return th.toString();
        }
    }

    public static String UpdateByID(String what, String id) {
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "UPDATE out_user SET " + what + " WHERE user_id = " + id + ";";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            int back = stmt.executeUpdate(sql);
            if(back == 1) {
                return "OK";
            } else {
                return "操作失败！";
            }
        } catch (Throwable th) {
            return th.toString();
        }
    }
    public static String UpdateByID(String what, String id, boolean autoLong) throws SQLException {
        // if(what.contains(",")) {
        //     return "UpdateByID ONLY ONE";
        // }
        String[] things = what.split("=");
        Statement stmt = SQLConnecter.conn.createStatement();
        // String sql = "ALTER table out_user modify column " + things[0] + " varchar(" + things[1].getBytes(StandardCharsets.UTF_8).length + ");";
        // System.out.println("================> 数据库操作\n" + sql);
        // int back = stmt.executeUpdate(sql);
        // if(back != 1) {
        //     return "操作失败！(1)";
        // }
        String sql = "UPDATE out_user SET " + things[0] + "='" + things[1] + "' WHERE user_id = " + id + ";";
        System.out.println("================> 数据库操作\n" + sql);
        // 请求查询
        int back = stmt.executeUpdate(sql);
        if(back != 1) {
            return "操作失败！(2)";
        }
        return "OK";
    }

    public static String insert(String what, String things) {
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "INSERT INTO out_user (" + what + ") VALUES (" + things + ");";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            int back = stmt.executeUpdate(sql);
            if(back == 1) {
                return "OK";
            } else {
                return "操作失败！";
            }
        } catch (Throwable th) {
            return th.toString();
        }
    }

}
