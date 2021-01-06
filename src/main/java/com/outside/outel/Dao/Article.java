package com.outside.outel.Dao;

import com.outside.outel.Layer.SQLConnecter;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2021/1/5 下午 07:21
 * @ClassName: Article
 * @Author: Stapx Steve
 * @Description TODO out_article 表相关操作（Article 相关操作）
 **/
public class Article {

    public static String insert(String what, String things) {
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "INSERT INTO out_article (" + what + ") VALUES (" + things + ");";
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

    public static List<Dao.SQLVer> selectByArtID(String what, String id) {
        List<Dao.SQLVer> info = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT " + what + " from out_article WHERE article_id = " + id + ";";
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

    public static List<List<Dao.SQLVer>> selectAllByID(String what, String id) {
        List<List<Dao.SQLVer>> info = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT " + what + " from out_article WHERE author_id = " + id + ";";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            ResultSet rs = stmt.executeQuery(sql);
            // 展开结果集数据库
            String[] names = what.split(",");
            while(rs.next()){
                // 通过字段检索
                List<Dao.SQLVer> infoOne = new ArrayList<>();
                for(String name: names) {
                    String get = rs.getString(name);
                    infoOne.add(new Dao.SQLVer(name, get));
                }
                info.add(infoOne);
            }
        } catch (Throwable th) {
            return info;
        }
        return info;
    }

    public static List<List<Dao.SQLVer>> selectAll(String what) {
        List<List<Dao.SQLVer>> info = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT " + what + " from out_article;";
            System.out.println("================> 数据库操作\n" + sql);
            // 请求查询
            ResultSet rs = stmt.executeQuery(sql);
            // 展开结果集数据库
            String[] names = what.split(",");
            while(rs.next()){
                // 通过字段检索
                List<Dao.SQLVer> infoOne = new ArrayList<>();
                for(String name: names) {
                    String get = rs.getString(name);
                    infoOne.add(new Dao.SQLVer(name, get));
                }
                info.add(infoOne);
            }
        } catch (Throwable th) {
            return info;
        }
        return info;
    }

}
