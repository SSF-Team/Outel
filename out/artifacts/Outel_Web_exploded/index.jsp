<%@ page import="java.util.Map" %>
<%@ page import="com.outside.outel.Util.URLTools" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.outside.outel.Service.TokenPass" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.outside.outel.Service.LoginOut" %>
<%@ page import="com.outside.outel.Dao.Dao" %>

<%@ page contentType="text/html; charset=UTF-8"%>

<%
//    String id = "";
//    String token = "";
//    String back = request.getParameter("back");
//    if(back == null) {
//        Map<String, String[]> parameterMap=request.getParameterMap();
//        StringBuilder parameterStr=new StringBuilder();
//        for(String key : parameterMap.keySet()){
//            parameterStr.append("&").append(key).append("=").append(URLTools.Encode(parameterMap.get(key)[0]));
//        }
//        response.sendRedirect("../LoginPass?back=home" + parameterStr);
//    } else {
//        try {
//            String[] str = back.split(" ");
//            List<Dao.SQLVer> infos = new ArrayList<>();
//            for (String info : str) {
//                if (info.contains(":")) {
//                    String[] inf = info.split(":");
//                    infos.add(new Dao.SQLVer(inf[0], inf[1]));
//                }
//            }
//            for (Dao.SQLVer info : infos) {
//                if (info.name.equals("ID")) {
//                    id = info.value;
//                }
//                if (info.name.equals("UUID")) {
//                    token = info.value;
//                }
//            }
//            if (!id.equals("") && !token.equals("")) {
//                try {
//                    String pass = TokenPass.Verification(id, token);
//                    if(pass.equals("OK")) {
//                        response.sendRedirect("/home");
//                    }
//                } catch (SQLException th) {
//                    th.printStackTrace();
//                    response.sendRedirect("error/error.jsp?err=" + back + "&type=500");
//                }
//            }
//        } catch (Throwable th) {
//            th.printStackTrace();
//        }
//    }
%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>Outel - 畅所欲言 / Outel</title>
    <link rel="icon" href="icon.png" sizes="32x32">

    <!-- 响应式触发 -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 样式表 -->
    <link href="bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/main.css" rel="stylesheet" type="text/css" id="colorCSS"/>
    <link rel="stylesheet" href="css/font-awesome.min.css">
</head>

<script type="text/javascript">
    // 判断系统是否在暗黑模式下并替换对应 CSS
    window.onload = function(){
        const css = document.getElementById("colorCSS");
        if(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            css.setAttribute("href","css/main_dark.css");
        } else {
            css.setAttribute("href","css/main.css");
        }
    }
</script>

<body>
    <div id="global">
        <div id="left" style="overflow:hidden;">
            <img src="svg/outel_no_c.svg" style="margin-left: -30%; width: 220%;"/>
            <div class="inboxLeft" style="color: white;">
                <img src="svg/iconmonstr-search-thin.svg" class="menuLeftIcon"/><font  class="menuLeft">精彩不止一“点”。</font><br><br>
                <img src="svg/iconmonstr-fish-2.svg" class="menuLeftIcon"/><font class="menuLeft">这波啊，这波是......快乐摸鱼！</font><br><br>
                <img src="svg/iconmonstr-party-14.svg" class="menuLeftIcon"/><font  class="menuLeft">与大家畅所欲言！干杯(゜-゜)つロ ~</font><br><br>
            </div>
        </div>
        <div id="right" style="overflow:hidden;">
            <div class="inboxRight">
                <img src="svg/outel_no_c.svg" style="height: 38px;"/><br><br>
                <font style="font-size: 27px;" class="fontBold">与您，与Ta，与我们；连接您的联结。</font><br><br><br>
                <font style="font-size: 15px;" class="fontBold">立即加入 Outel。</font><br><br>
                <button type="button" class="btn btn-primary" style="width: 100%;background-color: #53a1ff;border: 1px;border-radius: 20px;border-color: #69ADFF;" onclick="window.location.href='register.jsp'">
                    <font style="font-size: 18px;font-family: 'Microsoft YaHei';font-weight: bold;">注册</font>
                </button><br><br>
                <button type="button" class="btn btn-primary" style="width: 100%;background-color:transparent;color:#69ADFF;border-radius: 20px;border:1px solid #69ADFF;" onclick="window.location.href='login.jsp'">
                    <font style="font-size: 18px;font-family: 'Microsoft YaHei';font-weight: bold;">登录</font>
                </button>
            </div>
        </div>
        <div id="floor">
            outel.chuhelan.com © 2020 - 2021<a href="https://beian.miit.gov.cn/#/Integrated/index" target="_black">&nbsp;&nbsp;苏ICP备20015498号</a>
        </div>
    </div>
    </div>

    <script src="bootstrap/bootstrap.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>