package com.outside.outel.UserPasser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/* LoginPass.java
 * TODO 处理登录验证
 * By Stapx Steve 2020.12.25
 * Version 1.0
 */

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
                String name = new String(request.getParameter("name").getBytes("ISO8859-1"), "UTF-8");
                String docType = "<!DOCTYPE html> \n";
                // 输出页面
                out.println(docType +
                        "<html>\n" +
                        "<body>\n" +
                        "<ul>\n" +
                        "  <li><b>账户</b>："
                        + name + "\n" +
                        "  <li><b>密码（未加密）</b>："
                        + request.getParameter("url") + "\n" +
                        "</ul>\n" +
                        "</body></html>");
            } else {
                // 跳转回 index
                response.sendRedirect("/");
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