package com.outside.outel.Model;

import com.outside.outel.Dao.User;
import com.outside.outel.Service.Follow;
import com.outside.outel.Service.TokenPass;
import com.outside.outel.Util.URLTools;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Version: 1.0
 * @Date: 2021/1/4 上午 10:55
 * @ClassName: FollowUser
 * @Author: Stapx Steve
 * @Description TODO 跟随用户的处理页
 **/

// 跳转目录
@WebServlet("/Follow")

public class FollowUser extends HttpServlet {

    // 只处理 Get
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 高危操作需要再次验证
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
                List<User.SQLVer> infos = new ArrayList<>();
                for (String info : str) {
                    if (info.contains(":")) {
                        String[] inf = info.split(":");
                        infos.add(new User.SQLVer(inf[0], inf[1]));
                    }
                }
                for (User.SQLVer info : infos) { 
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
                            if(request.getParameter("type").equals("fl")) {
                                String backFollow = Follow.set(id, request.getParameter("follow"));
                                System.out.println(backFollow);
                                response.sendRedirect("/home/homeright.jsp?ID=" + id);
                            } else if(request.getParameter("type").equals("uf")){
                                String backFollow = Follow.delete(id, request.getParameter("follow"));
                                System.out.println(backFollow);
                                response.sendRedirect("/home/homeright.jsp?ID=" + id);
                            }
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
    }

}
