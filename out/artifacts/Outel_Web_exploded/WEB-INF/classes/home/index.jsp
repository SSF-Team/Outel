<%@ page import="java.util.Map" %>
<%@ page import="com.outside.outel.Util.URLTools" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="com.outside.outel.Dao.Dao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.outside.outel.Service.TokenPass" %>
<%@ page import="java.sql.SQLException" %>

<%@ page contentType="text/html; charset=UTF-8"%>

<%
    String id = "";
    String token = "";
    String back = request.getParameter("back");
    if(back == null) {
        Map<String, String[]> parameterMap=request.getParameterMap();
        StringBuilder parameterStr=new StringBuilder();
        for(String key : parameterMap.keySet()){
            parameterStr.append("&").append(key).append("=").append(URLTools.Encode(parameterMap.get(key)[0]));
        }
        response.sendRedirect("../LoginPass?back=home" + parameterStr);
    } else {
        try {
            String[] str = back.split(" ");
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
                    if(pass.equals("FAIL")) {
                        response.sendRedirect("../login.jsp?err=" + URLTools.Encode("验证登录失败，请重新登录账户！"));
                    } else if(pass.equals("NO")) {
                        response.sendRedirect("../login.jsp?err=" + URLTools.Encode("验证登录失败，请重新登录账户！"));
                    } else if(pass.equals("OK")) {

                    } else {
                        response.sendRedirect("../login.jsp?err=" + URLTools.Encode("抱歉操作失败，等会儿再试试？(W1)"));
                    }
                } catch (SQLException th) {
                    th.printStackTrace();
                    response.sendRedirect("error/error.jsp?err=" + back + "&type=500");
                }
            } else {
                response.sendRedirect("../login.jsp?err=" + URLTools.Encode("请登录账户！"));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    String name = "user_name";
    String head = "/svg/def.png";
    List<Dao.SQLVer> hinfo = User.selectByID("profile,user_name", id);
    boolean get = false;
    for(Dao.SQLVer info: hinfo) {
        if(info.name.equals("profile")) {
            get = true;
            head = info.value;
        }
        if(info.name.equals("user_name")) {
            get = true;
            name = info.value;
        }
    }
%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>主页 / Outel - 畅所欲言</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="../css/main.css">
</head>
<body>

<!--私信-->
<div id="RightBar" class="RightBottomBar" style="margin-bottom: -403px;">
    <div>私信</div>
    <div>
        <label>
        <button id="RightBarButton" style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;transform:rotate(0deg);" onclick="RightBottomBarClick('RightBar');">
            <img src="../svg/double_up.svg">
        </button>
        </label>
    </div>
    <div>
        <img src="../svg/sendmessage.svg">
    </div>
</div>





<!--home-->
<div class="home">

    <!--left home-->
    <div class="lefthome">
        <div class="lefthomeFirst">
            <div class="lefthomeLogo">
                <img src="../svg/outel_no_c.svg" height="35px" style="margin: 0 auto; margin-top: 8.5px;">
            </div>
            <!--    主页 nth-child2-->
            <button class="bonList" onclick="listCheck('tHome', 'pHome', 'homeindex.jsp?back=<%out.print(back);%>');">
                <img id="pHome" src="../svg/lefthome/zhuye_blue.svg">
                <span id="tHome" style="color: #1DA1F2;">主页</span>
            </button>
            <!--        探索-->
            <button class="bonList" onclick="listCheck('tSeach', 'pSeach', 'explore.jsp<%out.print("?ID=" + id);%>');">
                <img id="pSeach" src="../svg/lefthome/tansuo_black.svg">
                <span id="tSeach">探索</span>
            </button>
            <!--        通知-->
            <button class="bonList" onclick="listCheck('tInfo', 'pInfo', 'notifications.jsp');">
                <img id="pInfo" src="../svg/lefthome/tongzhi_black.svg">
                <span id="tInfo">通知</span>
            </button>
            <!--        私信-->
            <button class="bonList" onclick="listCheck('tMsg', 'pMsg', '');">
                <img id="pMsg" src="../svg/lefthome/sixin_black.svg">
                <span id="tMsg">私信</span>
            </button>
            <!--        书签-->
            <button class="bonList" onclick="listCheck('tMark', 'pMark', 'bookmarks.html');">
                <img id="pMark" src="../svg/lefthome/shuqian_black.svg">
                <span id="tMark">书签</span>
            </button>
            <!--        列表-->
            <button class="bonList" onclick="listCheck('tList', 'pList', '');">
                <img id="pList" src="../svg/lefthome/liebiao_black.svg">
                <span id="tList">列表</span>
            </button>
            <!--        个人资料-->
            <button class="bonList" onclick="listCheck('tMe', 'pMe', 'personalInfo.jsp?back=<%out.print(back);%>');">
                <img id="pMe" src="../svg/lefthome/ziliao_black.svg">
                <span id="tMe">我的</span>
            </button>

            <button type="button" class="btn btn-primary" style="cursor: pointer; outline: none; margin-top: 35px; width: 230px;height: 60px; background-color: #1DA1F2;border: 1px;border-radius: 60px;
                    border-color: #1DA1F2; box-shadow: 0px 0px 15px -9px #333333;" onclick="document.getElementById('homeindex').src='homeindex.jsp?back=<%out.print(back);%>';document.body.scrollTop = document.documentElement.scrollTop = 0;">
                <span style="font-size: 18px;font-family: 'Microsoft YaHei';font-weight: bold; color: #FFFFFF">OUT NOW</span>
            </button>


<%--    我不是文丽对话框div        --%>
            <div class="im_not_WenLi" style="visibility: collapse;" id="WenLi">
<%--        用户的个人信息        --%>
                <div>
                    <div style="border-radius: 50%; height: 49px; width: 49px; overflow: hidden; float: left;">
                        <img src="<%out.print(head);%>" height="49px" width="49px">
                    </div>
                    <div style="margin-left: 60px; padding-top: 3px;">
                        <span style="font-weight: bold;"><%out.print(name);%></span><br>
                        <span style="color: rgba(0,0,0,0.5)">@<%out.print(name);%></span>
                    </div>
                </div>
<%--         登出@XXXXX       --%>
                <div>
                    <button class="bonLogout" onclick="window.location.href='/LoginPass?type=out'">
                        <span>登出 @<%out.print(name);%></span>
                    </button>
                </div>

            </div>
<%--            --%>
            <div class="lefthomeSecond">
                <button class="meButton" onclick="showMenu('WenLi');">
                    <img src="

                    <%
                    out.print(head);
                    %>

                    ">
                    <div>
                        <font style="font-weight: bold;font-size: 16px;">

                            <%
                                out.print(name);
                            %>

                        </font><br>
                        <font style="font-size: 15px;color: rgba(0,0,0,0.6)">@

                            <%
                                out.print(name);
                            %>

                        </font>
                    </div>
                    <img src="../svg/more.svg">
                </button>
            </div>
        </div>
    </div>

    <!--center home-->
    <div class="centerhome">
        <%
        if(request.getParameter("user") != null) {
            out.print("        <iframe src=\"personalInfo.jsp?id=" + request.getParameter("user") + "&userid=" + id + "\" id=\"homeindex\" frameborder=\"no\" scrolling=\"no\" onload=\"this.height=this.contentWindow.document.documentElement.scrollHeight\" border=\"0\" width=\"100%\"></iframe>");
        } else if(request.getParameter("status") != null){

        } else {
            out.print("        <iframe src=\"homeindex.jsp?back=" + back + "\" id=\"homeindex\" frameborder=\"no\" scrolling=\"no\" onload=\"this.height=this.contentWindow.document.documentElement.scrollHeight\" border=\"0\" width=\"100%\"></iframe>");
        }
    %>
    </div>

    <!--right home-->
    <div class="righthome">
        <iframe src="homeright.jsp<%out.print("?ID=" + id);%>" frameborder="no" border="0"scrolling="no" onload="this.height2=this.contentWindow.document.documentElement.scrollHeight" width="100%" height="100%"></iframe>
    </div>

</div>

<!-- 窗口 -->
<div class="overlay" id="Pan" style="visibility: collapse;">
    <div class="card cardLogin">
        <div id="topBarLogin" style="text-align: center;">
            <div style="text-align: left;margin-left: 50px;margin-right: 50px;">
                <img src="../svg/outel_no_c.svg" style="height: 35px;margin-top: 45px;"/>
                <input type="submit" value="保存" class="bonSave"/>
            </div>
            <div style="margin: 50px;text-align: left;margin-top: 65px;">


            </div>
        </div>
    </div>
    <button class="ExitPan" onclick="document.getElementById('Pan').style.visibility = 'collapse';"></button>
</div>

<script src="home.js"></script>

</body>
</html>