package com.outside.outel.Model;

import com.outside.outel.Dao.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.List;

/**
 * @Version: 1.0
 * @Date: 2021/1/1 下午 04:06
 * @ClassName: GetAvatars
 * @Author: Stapx Steve
 * @Description TODO 输出用户头像
 **/

// 跳转目录
@WebServlet("/GetAvatars")

public class GetAvatars extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        if (request.getParameter("id") != null) {
            // 获图片地址
            String FileAdd = "Outel/Avatars/" + request.getParameter("id") + ".png";
            // 返回图片
            FileInputStream fis = null;
            response.setContentType("image/gif");
            try {
                OutputStream out = response.getOutputStream();
                File file = new File(FileAdd);
                fis = new FileInputStream(file);
                byte[] b = new byte[fis.available()];
                fis.read(b);
                out.write(b);
                out.flush();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
