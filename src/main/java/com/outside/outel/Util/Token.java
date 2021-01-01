package com.outside.outel.Util;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

/**
 * @Version: 1.0
 * @Date: 2020/12/28 下午 02:17
 * @ClassName: Token
 * @Author: Stapx Steve
 * @Description TODO Token 相关类
 **/
public class Token {

    public static String createToken() {
        // 生成 32 位 UUID 作为 Token
        return UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
    }

    /**
     *
     * @author billtsang
     *
     */
    public class HttpClient {
        Map<String, String> parameter=new HashMap<String, String>();
        HttpServletResponse response;

        public HttpClient(HttpServletResponse response)
        {
            this.response=response;
        }
        public void setParameter(String key,String value)
        {
            this.parameter.put(key, value);
        }
        public void sendByPost(String url) throws IOException
        {
            this.response.setContentType("text/html");
            PrintWriter out = this.response.getWriter();
            out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
            out.println("<HTML>");
            out.println(" <HEAD><TITLE>sender</TITLE></HEAD>");
            out.println(" <BODY>");
            out.println("<form name=\"submitForm\" action=\""+url+"\" method=\"post\">");
            Iterator<String> it=this.parameter.keySet().iterator();
            while(it.hasNext())
            {
                String key=it.next();
                out.println("<input type=\"hidden\" name=\""+key+"\" value=\""+this.parameter.get(key)+"\"/>");
            }
            out.println("</from>");
            out.println("<script>window.document.submitForm.submit();</script> ");
            out.println(" </BODY>");
            out.println("</HTML>");
            out.flush();
            out.close();

        }
    }

}
