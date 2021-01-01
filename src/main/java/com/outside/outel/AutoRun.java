package com.outside.outel;

import com.outside.outel.Layer.SQLConnecter;
import com.outside.outel.Layer.OptionReader;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.IOException;

/**
 * @Author Stapx Steve
 * @Description TODO 在启动 WEB 时进行任务执行。 From https://blog.csdn.net/wqc19920906/article/details/78931171
 * @Date 下午 04:47 2020/12/25
**/

public class AutoRun implements ServletContextListener{
    // 启动时执行
    public void contextInitialized(ServletContextEvent arg0) {
        System.out.println("================> 自动加载启动开始");

        // 读取设置
        System.out.println("> 正在读取设置……");
        OptionReader optReader = new OptionReader();
        try {
            optReader.ReadOpt();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 连接数据库
        System.out.println("> 正在连接数据库...");
        SQLConnecter sqlConer = new SQLConnecter();
        if(sqlConer.ConnectSQL())
        {
            System.out.println("连接数据库成功！");
        } else {
            System.out.println("连接数据库失败。请注意此条报错！这意味着接下来的所有 MySQL 操作将会全部报错！");
        }

        System.out.println("================> 自动加载启动结束");
    }

    // 关闭时执行
    public void contextDestroyed(ServletContextEvent servletContextEvent) {}
}