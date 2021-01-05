package com.outside.outel.Model;

import com.outside.outel.Dao.Dao;
import com.outside.outel.Service.Follow;
import com.outside.outel.Service.TokenPass;
import com.outside.outel.Util.URLTools;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Version: 1.0
 * @Date: 2021/1/5 下午 06:44
 * @ClassName: OutNow
 * @Author: Stapx Steve
 * @Description TODO 发送 Out
 **/

// 跳转目录
@WebServlet("/OutNow")

public class OutNow extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 只处理 POST 方法
        if(request.getParameter("ID") != null && request.getParameter("UUID") != null) {
            // 验证登录
            if(request.getParameter("back") == null) {
                Map<String, String[]> parameterMap=request.getParameterMap();
                StringBuilder parameterStr = new StringBuilder();
                for(String key : parameterMap.keySet()){
                    parameterStr.append("&").append(key).append("=").append(URLTools.Encode(parameterMap.get(key)[0]));
                }
                response.sendRedirect("../LoginPass?back=Follow" + parameterStr);
            } else {
                String back = request.getParameter("back");
                try {
                    String[] str = back.split(" ");
                    String id = "";
                    String token = "";
                    List<Dao.SQLVer> infos = new ArrayList<>();
                    for (String info : str) {
                        if (info.contains(":")) {
                            String[] inf = info.split(":");
                            infos.add(new Dao.SQLVer(inf[0], inf[1]));
                        }
                    }
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
                            String pass = TokenPass.Verification(id, token);
                            if(pass.equals("OK")) {
                                // TODO 保存 Out

                            }
                        } catch (SQLException th) {
                            th.printStackTrace();
                            response.sendRedirect("error/error.jsp?err=" + back + "&type=500");
                        }
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("../login.jsp?err=" + URLTools.Encode("请登录账户！"));
        }
    }

}
