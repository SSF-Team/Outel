package com.outside.outel.Model;

import com.outside.outel.Dao.Article;
import com.outside.outel.Dao.Dao;
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
 * @Date: 2021/1/6 下午 04:11
 * @ClassName: Like
 * @Author: Stapx Steve
 * @Description TODO 喜欢按钮的点击处理
 **/

// 跳转目录
@WebServlet("/Like")

public class Like extends HttpServlet {

    // 只处理 Get 请求
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 验证登录
        if(request.getParameter("back") == null) {
            Map<String, String[]> parameterMap=request.getParameterMap();
            StringBuilder parameterStr = new StringBuilder();
            for(String key : parameterMap.keySet()){
                parameterStr.append("&").append(key).append("=").append(URLTools.Encode(parameterMap.get(key)[0]));
            }
            response.sendRedirect("../LoginPass?back=Like" + parameterStr);
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
                            // TODO 操作数据库
                            if(request.getParameter("type").equals("unlike")) {
                                System.out.println("================> 取消喜欢");
                                // 取消喜欢
                                String likers = "";
                                List<Dao.SQLVer> infoArt = Article.selectByArtID("liker", request.getParameter("artid"));
                                for(Dao.SQLVer info: infoArt) {
                                    if(info.name.equals("liker")) {
                                        likers = info.value;
                                    }
                                }
                                System.out.println("> " + likers);
                                // 删除 ID
                                StringBuilder out = new StringBuilder();
                                if(likers.contains(",")) {
                                    String[] likes = likers.split(",");
                                    for(String stra: likes) {
                                        if(!stra.equals(id) && !stra.equals("")) {
                                            out.append(",").append(stra);
                                        }
                                    }
                                }
                                System.out.println("> End:" + out);
                                System.out.println("> Back:" + request.getParameter("backto"));
                                String backArt = Article.UpdateByArtID("liker='" + out + "'", request.getParameter("artid"));
                                if(backArt.equals("OK")) {
                                    response.sendRedirect(request.getParameter("backto"));
                                } else {
                                    response.sendRedirect(request.getParameter("backto") + "&err=" + backArt);
                                }
                            } else if(request.getParameter("type").equals("like")) {
                                System.out.println("================> 喜欢");
                                // 喜欢
                                String likers = "";
                                List<Dao.SQLVer> infoArt = Article.selectByArtID("liker", request.getParameter("artid"));
                                for(Dao.SQLVer info: infoArt) {
                                    if(info.name.equals("liker")) {
                                        likers = info.value;
                                    }
                                }
                                System.out.println("> " + likers);
                                // 添加 ID
                                String out = likers + "," + id;
                                System.out.println("> End:" + out);
                                System.out.println("> Back:" + request.getParameter("backto"));
                                String backArt = Article.UpdateByArtID("liker='" + out + "'", request.getParameter("artid"));
                                if(backArt.equals("OK")) {
                                    response.sendRedirect(request.getParameter("backto"));
                                } else {
                                    response.sendRedirect(request.getParameter("backto") + "&err=" + backArt);
                                }
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
