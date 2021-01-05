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
                    if(!pass.equals("OK")) {
                        response.sendRedirect("about:blank");
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
    <title>HOME / Outel - 畅所欲言</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="homeindex.css">
</head>

<script type="text/javascript">
    window.onload = function(){
        // 移动焦点
        document.getElementById('send_out').focus();
        document.getElementById('send_out').blur();
    }
</script>

<body>

<!--Center Top Bar-->
<div class="centerTopBar">
    <div>
        <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.2rem; color: #000000; line-height: 53px">主页</span>
        <img src="icon.png" height="37px" style="position: absolute; right: 0px; padding-right: 15px; margin-top: 8px">
    </div>
</div>

<!--center home-->
<div class="centerhome">

    <!--        Out now -->
    <div class="OutNowBar">
<!--   第二层的div     -->
        <div class="SecondFloor">
        <!--          右侧文本域-->
            <div class="TextFiled">
                <!--          左侧的头像div  -->
                <div class="leftPhoto">
                    <!--    控制头像是圆形的div     -->
                    <div class="circle">
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

                    " style="height: 49px; width: 49px">
                    </div>
                </div>
                <textarea id="send_out" onfocus="if(this.value=='开始你的表演~') {this.value='';}
                this.style.color='#6E8091';" onblur="if(this.value=='')
                {this.value='开始你的表演~';this.style.color='#6E8091';}" oninput="changeTextarea('send_out')"></textarea>
            </div>
        </div>
<!--        settings       -->
        <div class="settings">
            <button><img src="../svg/tupian.svg" height="22"></button>
            <button><img src="../svg/GIF.svg" height="28"></button>
            <button style="background-color: #1DA1F2; border: none; width: 120px; height: 40px;
            font-family: 'Microsoft YaHei'; font-weight: bold; color: #FFFFFF;
            border-radius: 30px; margin-top: 9px;">
                Out Now !
            </button>
        </div>
    </div>


    <!--        This is a cut line with #F7F9FA-->
    <div class="cutline"></div>

    <!--    好友内容的部分-->
    <!--    推送的大div   -->
    <div class="newspull">
        <div style="width: 569px; padding-top: 10px"></div>

    <!--   左侧头像div     -->
        <div class="personalPhoto"><img src="icon.png" height="49"></div>

    <!--   头像右侧     -->
    <!--   第一行 ID + 是否认证 + @用户id + 发表时间         -->
        <div class="rightContent">
            <div class="mainInfo">
                <a href="" >Outel</a>
                <img src="../svg/official.svg">
                <a href="">@OutelOfficial</a>
                <span>&nbsp;·&nbsp;12月26日</span>
            </div>
    <!--    这一行写的是内容 发送的内容  height = 510px      -->
            <div class="content">
                <span>
                    欢迎来到OutsideTeam打造的Outel。与您，与Ta，与我们；连接您的联结。
                   Outel带你欣赏世界上每一个精彩瞬间,了解每一个幕后故事。
                    分享你想表达的,让全世界都能听到你的心声!
                </span>
            </div>
            <div class="fifTeenPxDiv"></div>
    <!--    可有可无的图片div        -->
            <div class="contentPic">
                <img src="../svg/chinese-new-year.png">
            </div>

            <!--   评论 转推 点赞 转发   互动功能       -->
            <div class="huDong">
            <!-- 评论               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/pinglun.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        323
                    </span>
                </button>
            <!-- 转推               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/zhuantui.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        1,456
                    </span>
                </button>
            <!-- 喜欢               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/xihuan.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        3.2M
                    </span>
                </button>
            <!-- 分享               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/fenxiang.svg" height="18">
                </button>
            </div>
        </div>
    </div>



    <!--    好友内容的部分-->
    <!--    推送的大div   -->
    <div class="newspull">
        <div style="width: 569px; padding-top: 10px"></div>

        <!--   左侧头像div     -->
        <div class="personalPhoto"><img src="icon.png" height="49"></div>

        <!--   头像右侧     -->
        <!--   第一行 ID + 是否认证 + @用户id + 发表时间         -->
        <div class="rightContent">
            <div class="mainInfo">
                <a href="" >Outel</a>
                <img src="../svg/official.svg">
                <a href="">@OutelOfficial</a>
                <span>&nbsp;·&nbsp;12月26日</span>
            </div>
            <!--    这一行写的是内容 发送的内容  height = 510px      -->
            <div class="content">
                <span>
                    欢迎来到OutsideTeam打造的Outel。与您，与Ta，与我们；连接您的联结。
                   Outel带你欣赏世界上每一个精彩瞬间,了解每一个幕后故事。
                    分享你想表达的,让全世界都能听到你的心声!
                </span>
            </div>
<!--            <div class="fifTeenPxDiv"></div>-->
<!--            &lt;!&ndash;    可有可无的图片div        &ndash;&gt;-->
<!--            <div class="contentPic">-->
<!--                <img src="../svg/chinese-new-year.png">-->
<!--            </div>-->

            <!--   评论 转推 点赞 转发   互动功能       -->
            <div class="huDong">
                <!-- 评论               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/pinglun.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        323
                    </span>
                </button>
                <!-- 转推               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/zhuantui.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        1,456
                    </span>
                </button>
                <!-- 喜欢               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/xihuan.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        3.2M
                    </span>
                </button>
                <!-- 分享               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/fenxiang.svg" height="18">
                </button>
            </div>
        </div>
    </div>


    <!--    好友内容的部分-->
    <!--    推送的大div   -->
    <div class="newspull">
        <div style="width: 569px; padding-top: 10px"></div>

        <!--   左侧头像div     -->
        <div class="personalPhoto"><img src="icon.png" height="49"></div>

        <!--   头像右侧     -->
        <!--   第一行 ID + 是否认证 + @用户id + 发表时间         -->
        <div class="rightContent">
            <div class="mainInfo">
                <a href="" >Outel</a>
                <img src="../svg/official.svg">
                <a href="">@OutelOfficial</a>
                <span>&nbsp;·&nbsp;12月26日</span>
            </div>
            <!--    这一行写的是内容 发送的内容  height = 510px      -->
            <div class="content">
                <span>
                    欢迎来到OutsideTeam打造的Outel。与您，与Ta，与我们；连接您的联结。
                   Outel带你欣赏世界上每一个精彩瞬间,了解每一个幕后故事。
                    分享你想表达的,让全世界都能听到你的心声!
                </span>
            </div>
            <div class="fifTeenPxDiv"></div>
            <!--    可有可无的图片div        -->
            <div class="contentPic">
                <img src="../svg/chinese-new-year.png">
            </div>

            <!--   评论 转推 点赞 转发   互动功能       -->
            <div class="huDong">
                <!-- 评论               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/pinglun.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        323
                    </span>
                </button>
                <!-- 转推               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/zhuantui.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        1,456
                    </span>
                </button>
                <!-- 喜欢               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/xihuan.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        3.2M
                    </span>
                </button>
                <!-- 分享               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/fenxiang.svg" height="18">
                </button>
            </div>
        </div>
    </div>



    <!--    好友内容的部分-->
    <!--    推送的大div   -->
    <div class="newspull">
        <div style="width: 569px; padding-top: 10px"></div>

        <!--   左侧头像div     -->
        <div class="personalPhoto"><img src="icon.png" height="49"></div>

        <!--   头像右侧     -->
        <!--   第一行 ID + 是否认证 + @用户id + 发表时间         -->
        <div class="rightContent">
            <div class="mainInfo">
                <a href="" >Outel</a>
                <img src="../svg/official.svg">
                <a href="">@OutelOfficial</a>
                <span>&nbsp;·&nbsp;12月26日</span>
            </div>
            <!--    这一行写的是内容 发送的内容  height = 510px      -->
            <div class="content">
                <span>
                    欢迎来到OutsideTeam打造的Outel。与您，与Ta，与我们；连接您的联结。
                   Outel带你欣赏世界上每一个精彩瞬间,了解每一个幕后故事。
                    分享你想表达的,让全世界都能听到你的心声!
                </span>
            </div>
            <div class="fifTeenPxDiv"></div>
            <!--    可有可无的图片div        -->
            <div class="contentPic">
                <img src="../svg/chinese-new-year.png">
            </div>

            <!--   评论 转推 点赞 转发   互动功能       -->
            <div class="huDong">
                <!-- 评论               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/pinglun.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        323
                    </span>
                </button>
                <!-- 转推               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/zhuantui.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        1,456
                    </span>
                </button>
                <!-- 喜欢               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/xihuan.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        3.2M
                    </span>
                </button>
                <!-- 分享               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/fenxiang.svg" height="18">
                </button>
            </div>
        </div>
    </div>



    <!--    好友内容的部分-->
    <!--    推送的大div   -->
    <div class="newspull">
        <div style="width: 569px; padding-top: 10px"></div>

        <!--   左侧头像div     -->
        <div class="personalPhoto"><img src="icon.png" height="49"></div>

        <!--   头像右侧     -->
        <!--   第一行 ID + 是否认证 + @用户id + 发表时间         -->
        <div class="rightContent">
            <div class="mainInfo">
                <a href="" >Outel</a>
                <img src="../svg/official.svg">
                <a href="">@OutelOfficial</a>
                <span>&nbsp;·&nbsp;12月26日</span>
            </div>
            <!--    这一行写的是内容 发送的内容  height = 510px      -->
            <div class="content">
                <span>
                    欢迎来到OutsideTeam打造的Outel。与您，与Ta，与我们；连接您的联结。
                   Outel带你欣赏世界上每一个精彩瞬间,了解每一个幕后故事。
                    分享你想表达的,让全世界都能听到你的心声!
                </span>
            </div>
            <div class="fifTeenPxDiv"></div>
            <!--    可有可无的图片div        -->
            <div class="contentPic">
                <img src="../svg/chinese-new-year.png">
            </div>

            <!--   评论 转推 点赞 转发   互动功能       -->
            <div class="huDong">
                <!-- 评论               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/pinglun.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        323
                    </span>
                </button>
                <!-- 转推               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/zhuantui.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        1,456
                    </span>
                </button>
                <!-- 喜欢               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/xihuan.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        3.2M
                    </span>
                </button>
                <!-- 分享               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/fenxiang.svg" height="18">
                </button>
            </div>
        </div>
    </div>



    <!--    好友内容的部分-->
    <!--    推送的大div   -->
    <div class="newspull">
        <div style="width: 569px; padding-top: 10px"></div>

        <!--   左侧头像div     -->
        <div class="personalPhoto"><img src="icon.png" height="49"></div>

        <!--   头像右侧     -->
        <!--   第一行 ID + 是否认证 + @用户id + 发表时间         -->
        <div class="rightContent">
            <div class="mainInfo">
                <a href="" >Outel</a>
                <img src="../svg/official.svg">
                <a href="">@OutelOfficial</a>
                <span>&nbsp;·&nbsp;12月26日</span>
            </div>
            <!--    这一行写的是内容 发送的内容  height = 510px      -->
            <div class="content">
                <span>
                    欢迎来到OutsideTeam打造的Outel。与您，与Ta，与我们；连接您的联结。
                   Outel带你欣赏世界上每一个精彩瞬间,了解每一个幕后故事。
                    分享你想表达的,让全世界都能听到你的心声!
                </span>
            </div>
<!--            <div class="fifTeenPxDiv"></div>-->
<!--            &lt;!&ndash;    可有可无的图片div        &ndash;&gt;-->
<!--            <div class="contentPic">-->
<!--                <img src="../svg/chinese-new-year.png">-->
<!--            </div>-->

            <!--   评论 转推 点赞 转发   互动功能       -->
            <div class="huDong">
                <!-- 评论               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/pinglun.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        323
                    </span>
                </button>
                <!-- 转推               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/zhuantui.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        1,456
                    </span>
                </button>
                <!-- 喜欢               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/xihuan.svg" height="18">
                    <span style="position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;">
                        3.2M
                    </span>
                </button>
                <!-- 分享               -->
                <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;">
                    <img src="../svg/fenxiang.svg" height="18">
                </button>
            </div>
        </div>
    </div>





<script src="home.js"></script>


</div>

</body>
</html>