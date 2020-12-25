package com.outside.outel.SQL;

import com.outside.outel.ToolClass.OptionReader;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @Author Stapx Steve
 * @Description 连接到数据库
 * @Date 下午 04:53 2020/12/25
**/

public class SQLConnecter {

public static Connection conn;
private static final OptionReader opt = new OptionReader();

public boolean ConnectSQL() {
    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://" + opt.GetOpt("SQLAdd") + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    String USER = opt.GetOpt("SQLAcc");
    String PASS = opt.GetOpt("SQLPwd");

    try{
        // 注册 JDBC 驱动
        Class.forName(JDBC_DRIVER);

        // 打开链接
        System.out.println("连接数据库...");
        conn = DriverManager.getConnection(DB_URL,USER,PASS);

    } catch(Exception se){
        // 处理 JDBC 错误
        se.printStackTrace();
        return false;
    }
    System.out.println("连接数据库完成。");
    return true;
}

}
