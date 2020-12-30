package com.outside.outel.Model;

import com.outside.outel.Dao.*;
import com.outside.outel.Util.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author Stapx Steve
 * @Description TODO 进行登录处理
 * @Date 下午 04:49 2020/12/25
**/

// 跳转目录
@WebServlet("/LoginPass")

public class LoginPass extends HttpServlet {

    public LoginPass() {
        super();
        // TODO Auto-generated constructor stub
    }

    // 处理 POST 方法请求的方法
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // 只响应 POST 请求
            if (request.getMethod().equals("POST")) {
                // 设置页面编码
                response.setContentType("text/html;charset=UTF-8");
                // 验证登录
                if(request.getParameter("account").isEmpty() || request.getParameter("password").isEmpty()) {
                    // 跳转回登陆界面（不会改变地址栏上的 URL）
                    request.getRequestDispatcher("/login.jsp?err=" + URL.Encode("输入为空，认真点！")).forward(request,response);
                    return;
                }
                String loginBack = Login(request.getParameter("account"), request.getParameter("password"));
                if(loginBack.equals("OK")) {
                    // 生成 Token

                    // 跳转主页
                    response.sendRedirect("home");
                } else if(loginBack.equals("FAIL")) {
                    // 跳转回登陆界面（不会改变地址栏上的 URL）
                    request.getRequestDispatcher("/login.jsp?err=" + URL.Encode("账户或者密码错误，再试试？") + "&email=" + request.getParameter("account")).forward(request,response);
                } else {
                    // 跳转到 500
                    response.sendRedirect("error/error.jsp?err=" + loginBack + "&type=500");
                }
            } else {
                // 跳转回 index
                response.sendRedirect("/login.jsp");
            }
        } catch (Throwable th) {
            // 跳转到 500
            response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
        }
    }

    /**
     * @Author Stapx Steve
     * @Description TODO 进行登录验证
     * @Date 下午 01:55 2020/12/28
     * @Param [acc, password]
     * @return java.lang.String
    **/
    private String Login(String acc, String password) throws SQLException {
        List<User.SQLVer> infos = User.selectByMail("password", acc);
        for(User.SQLVer info: infos) {
            if(info.name.equals("password") && info.value.equals(password)) {
                System.out.println("================> 登录操作\n" + info.value + " -> Pass");
                return "OK";
            } else {
                System.out.println("================> 登录操作\n" + info.value + " -> UnPass");
                return "FALSE";
            }
        }
        return "FAIL";
    }

    private boolean setToken(String acc) {
        // 生成 Token
        return false;
    }
}