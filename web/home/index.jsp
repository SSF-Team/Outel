<%@ page import="java.util.Map" %>
<%@ page import="com.outside.outel.Util.URLTools" %>
<%@ page import="com.outside.outel.Dao.User" %>
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
%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>主页 / Outel - 畅所欲言</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="home.css">
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
            <div>
                <div style="width: 120px; padding: 10px">
                    <img src="../svg/lefthome/zhuye_blue.svg" style="margin-top: 2px;">
                    <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.4rem; color: #1DA1F2; position:absolute; right: 150px">主页</span>
                </div>
            </div>
            <!--        探索-->
            <div>
                <div style="width: 120px; padding: 10px">
                    <img src="../svg/lefthome/tansuo_black.svg" style="margin-top: 2px;">
                    <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.4rem; color: #000000; position:absolute; right: 150px">探索</span>
                </div>
            </div>
            <!--        通知-->
            <div>
                <div style="width: 120px; padding: 10px">
                    <img src="../svg/lefthome/tongzhi_black.svg" style="margin-top: 2px;">
                    <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.4rem; color: #000000; position:absolute; right: 150px">通知</span>
                </div>
            </div>
            <!--        私信-->
            <div>
                <div style="width: 120px; padding: 10px">
                    <img src="../svg/lefthome/sixin_black.svg" style="margin-top: 2px;">
                    <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.4rem; color: #000000; position:absolute; right: 150px">私信</span>
                </div>
            </div>
            <!--        书签-->
            <div>
                <div style="width: 120px; padding: 10px">
                    <img src="../svg/lefthome/shuqian_black.svg" style="margin-top: 2px;">
                    <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.4rem; color: #000000; position:absolute; right: 150px">书签</span>
                </div>
            </div>
            <!--        列表-->
            <div>
                <div style="width: 120px; padding: 10px">
                    <img src="../svg/lefthome/liebiao_black.svg" style="margin-top: 2px;">
                    <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.4rem; color: #000000; position:absolute; right: 150px">列表</span>
                </div>
            </div>
            <!--        个人资料-->
            <div>
                <div style="width: 120px; padding: 10px">
                    <img src="../svg/lefthome/ziliao_black.svg" style="margin-top: 2px;">
                    <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.4rem; color: #000000; position:absolute; right: 150px">我的</span>
                </div>
            </div>

            <button type="button" class="btn btn-primary" style="cursor: pointer; outline: none; margin-top: 15px; width: 230px;height: 50px; background-color: #1DA1F2;border: 1px;border-radius: 30px;
            border-color: #1DA1F2; box-shadow: 0px 0px 15px -9px #333333;" onclick="window.location.href='write.jsp'">
                <span style="font-size: 18px;font-family: 'Microsoft YaHei';font-weight: bold; color: #FFFFFF">OUT NOW</span>
            </button>


<%--    我不是文丽对话框div        --%>
            <div class="im_not_WenLi">
<%--        用户的个人信息        --%>
                <div>
                    <div style="border-radius: 50%; height: 49px; width: 49px; overflow: hidden; float: left;">
                        <img src="../svg/DemoPhoto.jpg" height="49px" width="49px">
                    </div>
                    <div style="margin-left: 60px; padding-top: 3px;">
                        <span>我不是文丽</span><br>
                        <span style="color: rgba(0,0,0,0.5)">@chuhelan</span>
                    </div>
                </div>
<%--         登出@XXXXX       --%>
                <div>
                    <span>登出@</span>
                </div>

            </div>
<%--            --%>
            <div class="lefthomeSecond">
                <button class="meButton">
                    <img src="

                    <%
                    String name = "user_name";
                    List<User.SQLVer> hinfo = User.selectByID("profile,user_name", id);
                        boolean get = false;
                        for(User.SQLVer info: hinfo) {
                            if(info.name.equals("profile")) {
                                get = true;
                                out.print(info.value);
                            }
                            if(info.name.equals("user_name")) {
                                get = true;
                                name = info.value;
                            }
                        }
                        if(!get) {
                            //out.print("../svg/");
                        }
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




<!--    &lt;!&ndash;Center Top Bar&ndash;&gt;-->
<!--    <div class="centerTopBar">-->
<!--        <div>-->
<!--            <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.2rem; color: #000000; line-height: 53px">主页</span>-->
<!--            <img src="icon.png" height="37px" style="position: absolute; right: 0px; padding-right: 15px; margin-top: 8px">-->
<!--        </div>-->
<!--    </div>-->

    <!--center home-->
    <div class="centerhome">
    <iframe src="homeindex.jsp<%out.print("?back=" + back);%>" id="homeindex" frameborder="no" border="0" width="100%" height="100%"></iframe>

<!--&lt;!&ndash;        Out now &ndash;&gt;-->
<!--        <div class="outnowbar">-->

<!--        </div>-->


<!--&lt;!&ndash;        This is a cut line with #F7F9FA&ndash;&gt;-->
<!--        <div class="cutline"></div>-->
    </div>



    <!--right home-->
    <div class="righthome">
        <iframe src="homeright.jsp<%out.print("?ID=" + id);%>" frameborder="no" border="0" scrolling="auto" width="100%" height="100%"></iframe>
    </div>

</div>

<script src="home.js"></script>

</body>
</html>