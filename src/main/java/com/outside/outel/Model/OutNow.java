package com.outside.outel.Model;

import com.outside.outel.Dao.Article;
import com.outside.outel.Service.TokenPass;
import com.outside.outel.Util.Tools;
import com.outside.outel.Util.URLTools;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;

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

    //String

    public void doGet(HttpServletRequest request, HttpServletResponse response) {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 只处理 POST 方法
        if(request.getParameter("ID") != null && request.getParameter("UUID") != null) {
            // 验证登录
            String id = request.getParameter("ID");
            String token = request.getParameter("UUID");
            if (!id.equals("") && !token.equals("")) {
                try {
                    String pass = TokenPass.Verification(id, token);
                    if(pass.equals("OK")) {
                        // TODO 保存 Out
                        System.out.println(URLDecoder.decode(request.getParameter("outs"), "UTF-8"));
                        String backOut = Article.insert("text,author_id,article_time",
                                "'" + URLDecoder.decode(request.getParameter("outs"), "UTF-8") + "','" + id + "','" + Tools.GetDayString(0) + "'");
                        if(backOut.equals("OK")) {
//                            List<Dao.SQLVer> list = Article.selectByID("text", id);
//                            System.out.println("> ID:" + id + " 的所有文章有：");
//                            for(Dao.SQLVer info: list) {
//                                if(info.name.equals("text")) {
//                                    System.out.println("> " + info.value);
//                                }
//                            }
                            response.sendRedirect("/home/homeindex.jsp?back=ID:" + id + "%20UUID:" + token);
                        } else {
                            response.sendRedirect("/home/homeindex.jsp?back=ID:" + id + "%20UUID:" + token +"&err=" + backOut);
                        }
                    }
                } catch (SQLException th) {
                    th.printStackTrace();
                    response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
                }
            }
        } else {
            response.sendRedirect("../login.jsp?err=" + URLTools.Encode("账户验证失败，请刷新再试！"));
        }
    }

}
