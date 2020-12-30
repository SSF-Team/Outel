package com.outside.outel.Model;

import com.outside.outel.Util.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author Stapx Steve
 * @Description TODO 处理设置头像
 * @Date 下午 08:31 2020/12/26
**/


// 跳转目录
@WebServlet("/HerPass")

public class HerPass extends HttpServlet {

    public HerPass() {
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
                // 检查输入
                if(request.getParameter("img").isEmpty()) {
                    request.getRequestDispatcher("/register.jsp?err=" + URL.Encode("输入为空，认真点！")).forward(request,response);
                    return;
                }
                if(!request.getParameter("img").substring(0, 11).equals("data:image/")) {
                    request.getRequestDispatcher("/register.jsp?err=" + URL.Encode("这不是个图片！")).forward(request,response);
                    return;
                }
                // 处理图片

            } else {
                // 跳转回 index
                response.sendRedirect("/login.jsp");
            }
        } catch (Throwable th) {
            // 跳转到 500
            response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
        }
    }

}
