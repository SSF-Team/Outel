package com.outside.outel.Model;

import com.outside.outel.Dao.User;
import com.outside.outel.Util.*;

import javax.imageio.ImageIO;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.File;
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
                    request.getRequestDispatcher("/welcome/index.jsp?err=" + URLTools.Encode("没有图片欸！")).forward(request,response);
                    return;
                }
                if(request.getParameter("img").length() < 12 || !request.getParameter("img").substring(0, 11).equals("data:image/")) {
                    request.getRequestDispatcher("/welcome/index.jsp?err=" + URLTools.Encode("这不是个图片！")).forward(request,response);
                    return;
                }
                // 处理图片
                // 处理你妈
                // BufferedImage Bfimg = Img.getImangeInPic(Img.getBufferedImage(request.getParameter("img")), 30);
                // String img = Img.getBase64(Bfimg);
                // response.getWriter().write("<div id=\"labBg\" style=\"background-image: url("+ img +");width: 100%;height: 100%;background-repeat: no-repeat;\"></div>");

                // 保存图片
                BufferedImage bfImg = Img.getBufferedImage(request.getParameter("img"));
                File file =new File("Outel/Avatars");
                if(!file.exists()  && !file.isDirectory())
                {
                    file.mkdir();
                }
                File outputFile = new File("Outel/Avatars/" + request.getParameter("id") + ".png");
                ImageIO.write(bfImg,"png", outputFile);

                // 保存数据库
                String back = User.UpdateByID("profile='/GetAvatars?id=" + request.getParameter("id") + "'", request.getParameter("id"));
                if(back.equals("OK")) {
                    response.sendRedirect("/home");
                } else {
                    response.sendRedirect("error/error.jsp?err=" + back + "&type=500");
                }
            } else {
                // 跳转回 index
                response.sendRedirect("/login.jsp");
            }
        } catch (Throwable th) {
            th.printStackTrace();
            // 跳转到 500
            response.sendRedirect("error/error.jsp?err=" + th + "&type=500");
        }
    }

}
