package com.outside.outel.Model;

import com.outside.outel.Dao.Dao;
import com.outside.outel.Service.TokenPass;
import com.outside.outel.Util.Token;
import com.outside.outel.Util.Tools;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2020/12/29 上午 11:34
 * @ClassName: Debug
 * @Author: Stapxs
 * @Description TO DO
 **/

// 跳转目录
@WebServlet("/Debug")

public class Debug extends HttpServlet {

    public Debug() {
        super();
        // TODO Auto-generated constructor stub
    }

    // 处理 POST 方法请求的方法
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置页面编码
        response.setContentType("text/html;charset=UTF-8");
        // Run
        response.getWriter().write("生成随机 Token：<br>");
        response.getWriter().write(Token.createToken());

        response.getWriter().write("<br>生成时间字符串：<br>");
        response.getWriter().write(Tools.GetDayString(30));

        response.getWriter().write("<br>验证登录：");
        if (request.getParameter("back") == null) {
            response.sendRedirect("../LoginPass?back=Debug");
        } else {
            response.getWriter().write("(" + request.getParameter("back") + ")");
        }
        try {
            String[] str = request.getParameter("back").split(" ");
            List<Dao.SQLVer> infos = new ArrayList<>();
            for (String info : str) {
                if (info.contains(":")) {
                    String[] inf = info.split(":");
                    infos.add(new Dao.SQLVer(inf[0], inf[1]));
                }
            }
            String id = "";
            String token = "";
            for (Dao.SQLVer info : infos) {
                if (info.name.equals("ID")) {
                    id = info.value;
                }
                if (info.name.equals("UUID")) {
                    token = info.value;
                }
            }
            if (!id.equals("") && !token.equals("")) {
                try {
                    response.getWriter().write("<br>" + TokenPass.Verification(id, token));
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            } else {
                response.getWriter().write("<br>验证错误：" + id + " / " + token);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
