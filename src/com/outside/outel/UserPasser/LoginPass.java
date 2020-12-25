package com.outside.outel.UserPasser;

import com.outside.outel.SQL.SQLConnecter;
import com.outside.outel.ToolClass.urlClass;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

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
                if(request.getParameter("account").isBlank() || request.getParameter("password").isBlank()) {
                    // 跳转回登陆界面（不会改变地址栏上的 URL）
                    request.getRequestDispatcher("/login.jsp?err=" + urlClass.urlEncode("输入为空，认真点！")).forward(request,response);
                    return;
                }
                String loginBack = Login(request.getParameter("account"), request.getParameter("password"));
                if(loginBack.equals("OK")) {
                    response.getWriter().print("<script> alert(\"登陆成功！\"); </script>");
                } else if(loginBack.equals("FAIL")) {
                    // 跳转回登陆界面（不会改变地址栏上的 URL）
                    request.getRequestDispatcher("/login.jsp?err=" + urlClass.urlEncode("账户或者密码错误，再试试？") + "&email=" + request.getParameter("account")).forward(request,response);
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

    private String Login(String acc, String password) {
        try {
            // 执行查询
            Statement stmt = SQLConnecter.conn.createStatement();
            String sql = "SELECT email, password from out_user WHERE email = '" + acc + "';";
            System.out.println(sql);
            ResultSet rs = stmt.executeQuery(sql);

            // 展开结果集数据库
            while(rs.next()){
                // 通过字段检索
                String emailGet = rs.getString("email");
                String passwordGet = rs.getString("password");

                // 确认登录
                if(passwordGet.equals(password))
                    return "OK";
                else
                    return "FAIL";
            }
        } catch (Throwable th) {
            th.printStackTrace();
            return th.toString();
        }
        return "未知错误！";
    }
}