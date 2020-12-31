package com.outside.outel.Model;

import com.outside.outel.Dao.*;
import com.outside.outel.Layer.OptionReader;
import com.outside.outel.Util.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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
            // 只响应 POST 请求
            if (request.getMethod().equals("POST") && request.getParameter("type").equals("login")) {
                try {
                    // 设置页面编码
                    response.setContentType("text/html;charset=UTF-8");
                    // 验证登录
                    if (request.getParameter("account").isEmpty() || request.getParameter("password").isEmpty()) {
                        // 跳转回登陆界面（不会改变地址栏上的 URL）
                        request.getRequestDispatcher("/login.jsp?err=" + URLTools.Encode("输入为空，认真点！")).forward(request, response);
                        return;
                    }
                    String loginBack = Login(request.getParameter("account"), request.getParameter("password"));
                    if (loginBack.equals("OK")) {
                        // 生成 Token
                        String token = Token.createToken();
                        String time = Tools.GetDayString(30);
                        // 写入 Token
                        String back = User.UpdateByMail("token='" + token + "',token_dietime='" + time + "'", request.getParameter("account"));
                        if (back.equals("OK")) {
                            System.out.println(OptionReader.GetOpt("Domain"));
                            // 写入 Cookie
                            Cookie cookie = new Cookie("UUID", token);
                            cookie.setMaxAge(24 * 60 * 60 * 30);  // 有效期一个月
                            cookie.setDomain(OptionReader.GetOpt("Domain"));
                            response.addCookie(cookie);
                            // 获取 ID
                            List<User.SQLVer> infos = User.selectByMail("user_id", request.getParameter("account"));
                            for (User.SQLVer info : infos) {
                                if (info.name.equals("user_id")) {
                                    cookie = new Cookie("ID", info.value);
                                    cookie.setMaxAge(24 * 60 * 60 * 30);  // 有效期一个月
                                    cookie.setDomain(OptionReader.GetOpt("Domain"));
                                    response.addCookie(cookie);
                                    // 跳转主页
                                    response.sendRedirect("home");
                                    return;
                                }
                            }
                            request.getRequestDispatcher("/login.jsp?err=" + URLTools.Encode("抱歉操作失败，等会儿再试试？(1)") + "&email=" + request.getParameter("account")).forward(request, response);
                        } else if (back.equals("操作失败！")) {
                            request.getRequestDispatcher("/login.jsp?err=" + URLTools.Encode("抱歉操作失败，等会儿再试试？(2)") + "&email=" + request.getParameter("account")).forward(request, response);
                        } else {
                            response.sendRedirect("error/error.jsp?err=" + back + "&type=500");
                        }
                    } else if (loginBack.equals("FAIL")) {
                        // 跳转回登陆界面（不会改变地址栏上的 URL）
                        request.getRequestDispatcher("/login.jsp?err=" + URLTools.Encode("账户或者密码错误，再试试？") + "&email=" + request.getParameter("account")).forward(request, response);
                    } else {
                        // 跳转到 500
                        response.sendRedirect("error/error.jsp?err=" + loginBack + "&type=500");
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                    // 跳转到 500
                    response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
                }
            } else if(request.getParameter("back") != null){
                try {
                    System.out.println("================> 获取 Token");
                    // 返回 Cookie,id
                    StringBuilder back = new StringBuilder();
                    int get = 0;
                    Cookie[] cookies = request.getCookies();
                    for (Cookie cookie : cookies) {
                        switch (cookie.getName()) {
                            case "UUID":
                                back.append("UUID:").append(cookie.getValue()).append("+");
                                get++;
                                break;
                            case "ID":
                                back.append("ID:").append(cookie.getValue()).append("+");
                                get++;
                            default:
                                break;
                        }
                    }
                    if (get == 0) {
                        back = new StringBuilder("ERR:NULL");
                    }
                    if(request.getParameter("back").contains("http") ||
                            request.getParameter("back").contains("https")) {
                        response.sendRedirect("error/error.jsp?err=You Cant do it out the site&type=403");
                    } else {
                        request.getRequestDispatcher(request.getParameter("back") + "?back=" + back).forward(request, response);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                    // 跳转到 500
                    response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
                }
            } else {
                response.sendRedirect("/Login.jsp");
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
}