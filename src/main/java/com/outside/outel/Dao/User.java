package com.outside.outel.Dao;

import com.outside.outel.Layer.SQLConnecter;

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

    public static class SQLVer {
        public String name;
        public String value;

        public SQLVer(String name, String value) {
            this.name = name;
            this.value = value;
        }
    }

    public static List<SQLVer> selectByMail(String what, String mail) {
        List<SQLVer> info = new ArrayList<>();
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
                    info.add(new SQLVer(name, get));
                }
            }
        } catch (Throwable th) {
            info.add(new SQLVer("ERR", th.toString()));
            return info;
        }
        info.add(new SQLVer("ERR", "UNKNOWN"));
        return info;
    }

    public static List<SQLVer> selectByID(String what, String id) {
        List<SQLVer> info = new ArrayList<>();
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
                    info.add(new SQLVer(name, get));
                }
            }
        } catch (Throwable th) {
            info.add(new SQLVer("ERR", th.toString()));
            return info;
        }
        info.add(new SQLVer("ERR", "UNKNOWN"));
        return info;
    }

    public static List<SQLVer> selectAll(String what) {
        List<SQLVer> info = new ArrayList<>();
        if(what.contains(",")) {
            info.add(new SQLVer("ERR", "ONLY ONE"));
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
                info.add(new SQLVer(what, get));
            }
        } catch (Throwable th) {
            info.add(new SQLVer("ERR", th.toString()));
            return info;
        }
        info.add(new SQLVer("ERR", "UNKNOWN"));
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
        if(what.contains(",")) {
            return "ONLY ONE";
        }
        String[] things = what.split("=");
        Statement stmt = SQLConnecter.conn.createStatement();
        String sql = "ALTER table out_user modify column " + things[0] + " varchar(" + things[1].getBytes(StandardCharsets.UTF_8).length + ")";
        System.out.println("================> 数据库操作\n" + sql);
        int back = stmt.executeUpdate(sql);
        if(back != 1) {
            return "操作失败！";
        }
        sql = "UPDATE out_user SET " + things[0] + "='" + things[1] + "' WHERE user_id = " + id + ";";
        System.out.println("================> 数据库操作\n" + sql);
        // 请求查询
        back = stmt.executeUpdate(sql);
        if(back != 1) {
            return "操作失败！";
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
