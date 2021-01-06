<%@ page import="com.outside.outel.Util.URLTools" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="com.outside.outel.Service.TokenPass" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.outside.outel.Dao.Dao" %>
<%@ page import="com.outside.outel.Dao.Article" %>
<%@ page import="com.outside.outel.Util.Tools" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>

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
        document.getElementById('outs').focus();
        document.getElementById('outs').blur();
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
        <form action="/OutNow" method="post" onsubmit="return checkForm('outs');">
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
                        List<Dao.SQLVer> hinfo = User.selectByID("profile,user_name", id);
                            boolean get = false;
                            for(Dao.SQLVer info: hinfo) {
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
                    <textarea id="outs" name="outs" onfocus="if(this.value=='开始你的表演~') {this.value='';}
                    this.style.color='#6E8091';" onblur="if(this.value=='')
                    {this.value='开始你的表演~';this.style.color='#6E8091';}" oninput="changeTextarea('outs', 'bonOutNow');"></textarea>
                </div>
            </div>
<!--            settings       -->
            <div class="settings">
                <button><img src="../svg/tupian.svg" height="22"></button>
                <button><img src="../svg/GIF.svg" height="28"></button>
                <input id="bonOutNow" type="submit" class="outButton" value="Out Now !">
            </div>
            <%
                out.print("\n" +
                        "                <input type=\"text\" name=\"ID\" style=\"visibility: collapse;\" value=" + id + ">\n" +
                        "                <input type=\"text\" name=\"UUID\" style=\"visibility: collapse;\" value=" + token + ">");
            %>
        </form>
    </div>

    <!--        This is a cut line with #F7F9FA-->
    <div class="cutline"></div>


    <%
        // 输出纯文本 Out
        // 查询数据
        List<List<Dao.SQLVer>> infos = Article.selectAll("article_id,text,author_id,view_num,post_num,like_num,article_time,article_del");
        System.out.println("================> 所有文章");
        for(List<Dao.SQLVer> info: infos) {
            for(Dao.SQLVer art: info) {
                System.out.print(art.name + " - " + art.value + " / ");
            }
            System.out.println();
        }
        // 按时间排序（冒泡）
        int i, j;
        for(i=0; i<infos.size(); i++){
            for(j=1; j<infos.size()-i; j++){
                if(Integer.parseInt(infos.get(j-1).get(6).value.trim()) < Integer.parseInt(infos.get(j).get(6).value.trim())){
                    Collections.swap(infos, j-1, j);
                }
            }
        }
      System.out.println("> 排序结果：");
      for(List<Dao.SQLVer> info: infos) {
          for (Dao.SQLVer art : info) {
              if (art.name.equals("text")) {
                  System.out.print(art.value + "-");
              }
              if (art.name.equals("article_time")) {
                  System.out.println(art.value);
              }
          }
      }
        // 输出文章
        for(i=0; i<infos.size(); i++) {
            if(infos.size() < 30 || Integer.parseInt(infos.get(i).get(6).value.trim()) > Integer.parseInt(Tools.GetDayString(-10).trim())){
                // 处理时间
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
                Date date = formatter.parse(infos.get(i).get(6).value.trim());

                Calendar calendar = Calendar.getInstance();
                calendar.setTime(date);
                Calendar calendarNow = Calendar.getInstance();
                calendarNow.setTime(new Date());

                String dateShow = "";
                if(calendar.get(Calendar.YEAR)  == calendarNow.get(Calendar.YEAR)) {
                    if(calendar.get(Calendar.MONTH)  == calendarNow.get(Calendar.MONTH)) {
                        if(calendarNow.get(Calendar.DATE) - calendar.get(Calendar.DATE) == 0) {
                            dateShow = "今天";
                        } else {
                            dateShow = (calendarNow.get(Calendar.DATE) - calendar.get(Calendar.DATE)) + "天前";
                        }
                    } else {
                        dateShow = (calendar.get(Calendar.MONTH) + 1) + "月" + calendar.get(Calendar.DATE) + "日";
                    }
                } else {
                    dateShow = calendar.get(Calendar.YEAR) + "年" + (calendar.get(Calendar.MONTH) + 1) + "月" + calendar.get(Calendar.DATE) + "日";
                }
                // 获取用户信息
                List<Dao.SQLVer> userInfo = User.selectByID("user_name,profile,certification", infos.get(i).get(2).value.trim());
                String userName = "user_name";
                String profile = "/svg/def.png";
                String certification = "0";
                for(Dao.SQLVer info: userInfo) {
                    if(info.name.equals("user_name")) {
                        userName = info.value;
                    }
                    if(info.name.equals("profile")) {
                        profile = info.value;
                    }
                    if(info.name.equals("certification")) {
                        certification = info.value;
                    }
                }
                out.print(
                        "<div class=\"newspull\">\n" +
                                "        <div style=\"width: 569px; padding-top: 10px\"></div>\n" +
                                "        <div class=\"personalPhoto\"><img src=\"" + profile + "\" height=\"49\"></div>\n" +
                                "        <div class=\"rightContent\">\n" +
                                "            <div class=\"mainInfo\">\n" +
                                "                <a href=\"#\" >" + userName + "</a>\n");
                if(certification.equals("1")) {
                    out.print(
                                "                <img src=\"../svg/official.svg\">\n");} else {
                    out.print(
                            "                <img>\n");}
                    out.print(
                                "                <a href=\"#\">@" + userName + "</a>\n" +
                                "                <span>&nbsp;·&nbsp;" + dateShow + "</span>\n" +
                                "            </div>\n" +
                                "            <div class=\"content\">\n" +
                                "                <span>\n" +
                                                    infos.get(i).get(1).value.trim() +
                                "                </span>\n" +
                                "            </div>\n" +
                                "            <div class=\"huDong\">\n" +
                                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                                "                    <img src=\"../svg/pinglun.svg\" height=\"18\">\n" +
                                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n" +
                                                        "0" +
                                                        //infos.get(i).get(1).value.trim() +
                                "                    </span>\n" +
                                "                </button>\n" +
                                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                                "                    <img src=\"../svg/zhuantui.svg\" height=\"18\">\n" +
                                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n" +
                                                        "0" +
                                                        //infos.get(i).get(1).value.trim() +
                                "                    </span>\n" +
                                "                </button>\n" +
                                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                                "                    <img src=\"../svg/xihuan.svg\" height=\"18\">\n" +
                                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n" +
                                                        infos.get(i).get(5).value.trim() +
                                "                    </span>\n" +
                                "                </button>\n" +
                                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                                "                    <img src=\"../svg/fenxiang.svg\" height=\"18\">\n" +
                                "                </button>\n" +
                                "            </div>\n" +
                                "        </div>\n" +
                                "    </div>"
                );
            }
        }
        out.print(" <!--    好友内容的部分-->\n" +
                "    <!--    推送的大div   -->\n" +
                "    <div class=\"newspull\">\n" +
                "        <div style=\"width: 569px; padding-top: 10px\"></div>\n" +
                "\n" +
                "        <!--   左侧头像div     -->\n" +
                "        <div class=\"personalPhoto\"><img src=\"icon.png\" height=\"49\"></div>\n" +
                "\n" +
                "        <!--   头像右侧     -->\n" +
                "        <!--   第一行 ID + 是否认证 + @用户id + 发表时间         -->\n" +
                "        <div class=\"rightContent\">\n" +
                "            <div class=\"mainInfo\">\n" +
                "                <a href=\"\" >Outel</a>\n" +
                "                <img src=\"../svg/official.svg\">\n" +
                "                <a href=\"\">@OutelOfficial</a>\n" +
                "                <span>&nbsp;·&nbsp;12月26日</span>\n" +
                "            </div>\n" +
                "            <!--    这一行写的是内容 发送的内容  height = 510px      -->\n" +
                "            <div class=\"content\">\n" +
                "                <span>\n" +
                "                    欢迎来到OutsideTeam打造的Outel。与您，与Ta，与我们；连接您的联结。\n" +
                "                   Outel带你欣赏世界上每一个精彩瞬间,了解每一个幕后故事。\n" +
                "                    分享你想表达的,让全世界都能听到你的心声!\n" +
                "                </span>\n" +
                "            </div>\n" +
                "            <div class=\"fifTeenPxDiv\"></div>\n" +
                "            <!--    可有可无的图片div        -->\n" +
                "            <div class=\"contentPic\">\n" +
                "                <img src=\"../svg/chinese-new-year.png\">\n" +
                "            </div>\n" +
                "\n" +
                "            <!--   评论 转推 点赞 转发   互动功能       -->\n" +
                "            <div class=\"huDong\">\n" +
                "                <!-- 评论               -->\n" +
                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                "                    <img src=\"../svg/pinglun.svg\" height=\"18\">\n" +
                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n" +
                "                        323\n" +
                "                    </span>\n" +
                "                </button>\n" +
                "                <!-- 转推               -->\n" +
                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                "                    <img src=\"../svg/zhuantui.svg\" height=\"18\">\n" +
                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n" +
                "                        1,456\n" +
                "                    </span>\n" +
                "                </button>\n" +
                "                <!-- 喜欢               -->\n" +
                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                "                    <img src=\"../svg/xihuan.svg\" height=\"18\">\n" +
                "                    <span style=\"position: relative; bottom: 3px; padding-left: 10px; padding-right: 80px; color: #81919F;\">\n" +
                "                        3.2M\n" +
                "                    </span>\n" +
                "                </button>\n" +
                "                <!-- 分享               -->\n" +
                "                <button style=\"padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;\">\n" +
                "                    <img src=\"../svg/fenxiang.svg\" height=\"18\">\n" +
                "                </button>\n" +
                "            </div>\n" +
                "        </div>\n" +
                "    </div>\n");
    %>

<script src="home.js"></script>


</div>

</body>
</html>