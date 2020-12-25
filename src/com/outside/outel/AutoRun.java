package com.outside.outel;

import com.outside.outel.SQL.SQLConnecter;
import com.outside.outel.ToolClass.OptionReader;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.IOException;

/**
 * @Author Stapx Steve
 * @Description TODO 在启动 WEB 时进行任务执行， Code From https://blog.csdn.net/wqc19920906/article/details/78931171
 * @Date 下午 04:47 2020/12/25
**/

public class AutoRun implements ServletContextListener{
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
        }

        System.out.println("================> 自动加载启动结束");
    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {}
}