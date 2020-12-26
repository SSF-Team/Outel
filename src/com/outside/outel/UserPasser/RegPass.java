package com.outside.outel.UserPasser;

import com.outside.outel.SQL.SQLConnecter;
import com.outside.outel.ToolClass.Tools;
import com.outside.outel.ToolClass.urlClass;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * @Author Stapx Steve
 * @Description TODO 进行注册流程
 * @Date 下午 11:19 2020/12/25
**/

// 跳转目录
@WebServlet("/RegPass")

public class RegPass extends HttpServlet {

    public RegPass() {
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
                // 输入判定
                if(request.getParameter("name").isEmpty() || request.getParameter("email").isEmpty() || request.getParameter("password").isEmpty()) {
                    request.getRequestDispatcher("/register.jsp?err=" + urlClass.urlEncode("输入为空，认真点！")).forward(request,response);
                    return;
                }
                if(Tools.isSpecialChar(request.getParameter("name"))) {
                    request.getRequestDispatcher("/register.jsp?err=" + urlClass.urlEncode("用户名包含特殊字符，再检查下。") + "&name=" + urlClass.urlEncode(request.getParameter("name")) + "&mail=" + urlClass.urlEncode(request.getParameter("email"))).forward(request,response);
                    return;
                }
                if(!Tools.checkEmail(request.getParameter("email"))) {
                    request.getRequestDispatcher("/register.jsp?err=" + urlClass.urlEncode("邮箱格式错误，再检查下。") + "&name=" + urlClass.urlEncode(request.getParameter("name")) + "&mail=" + urlClass.urlEncode(request.getParameter("email"))).forward(request,response);
                }
                // 开始注册
                String regBack = Register(request.getParameter("name"), request.getParameter("email"), request.getParameter("password"));
                if(regBack.equals("EMAIL")) {
                    request.getRequestDispatcher("/register.jsp?err=" + urlClass.urlEncode("这个邮箱已经被注册过了哦") + "&name=" + urlClass.urlEncode(request.getParameter("name")) + "&mail=" + urlClass.urlEncode(request.getParameter("email"))).forward(request,response);
                } else if(regBack.equals("OK")) {
                    response.getWriter().print("<script> alert(\"注册成功！\"); </script>");
                } else {
                    response.sendRedirect("error/error.jsp?err=" + regBack + "&type=500");
                }
            } else {
                // 跳转回 index
                response.sendRedirect("/register.jsp");
            }
        } catch (Throwable th) {
            // 跳转到 500
            response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
        }
    }

    private String Register(String name, String email, String password) {
        try {
            Statement stmt = SQLConnecter.conn.createStatement();
            // 查询用户列表是否有重复的邮箱
            String sql = "SELECT email from out_user;";
            System.out.println("================> " + sql);
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String emailGet = rs.getString("email");
                if (emailGet.equals(email))
                    return "EMAIL";
            }
            // 写入用户信息
            sql = "INSERT INTO out_user (user_name, email, password) VALUES ('" + name + "', '" + email + "', '" + password + "');";
            System.out.println("================> " + sql);
            int back = stmt.executeUpdate(sql);
            if(back == 1) {
                return "OK";
            } else {
                return "操作失败！";
            }
        } catch (Throwable th) {
            th.printStackTrace();
            return th.toString();
        }
    }

}
