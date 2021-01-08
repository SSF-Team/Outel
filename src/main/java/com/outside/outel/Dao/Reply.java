package com.outside.outel.Dao;

import com.outside.outel.Layer.SQLConnecter;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2021/1/8 上午 11:33
 * @ClassName: Reply
 * @Author: Stapx Steve
 * @Description TODO out_article_comment 表相关操作（Reply 相关操作）
 **/
public class Reply {

    public static List<Dao.SQLVer> selectByArtID(String what, String id) {
        List<Dao.SQLVer> info = new ArrayList<>();
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT " + what + " from out_article_comment WHERE article_id = " + id + ";";
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

}
