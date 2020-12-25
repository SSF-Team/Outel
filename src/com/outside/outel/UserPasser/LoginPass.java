package com.outside.outel.UserPasser;

import java.io.IOException;
import java.io.PrintWriter;

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // 只响应 POST 请求
            if (request.getMethod().equals("POST")) {
                // 设置页面编码
                response.setContentType("text/html;charset=UTF-8");

                PrintWriter out = response.getWriter();
                // 处理中文
                String docType = "<!DOCTYPE html> \n";
                // 输出页面
                out.println(docType +
                        "账户："
                        + request.getParameter("account") + "<br>" +
                        "密码（简单进行了MD5加密）："
                        + request.getParameter("password")
                );
            } else {
                // 跳转回 index
                response.sendRedirect("/login.html");
            }
        } catch (Throwable th) {
            // 跳转到 500
            response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
        }
    }

    // 处理 POST 方法请求的方法
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }
}