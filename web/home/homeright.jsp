<%@ page import="com.outside.outel.Service.GetUser" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="com.outside.outel.Dao.Dao" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>搜索 / Outel - 畅所欲言</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="homeright.css">
</head>
<body>

<div class="righthome">

    <div style="height: 15px"></div>
<!--  搜索框div  #EBEEF0 350*45  -->
    <label class="Search" id="search_lab">
        <img src="../svg/serch.svg" height="18px" width="18px" style="float:left; margin-left: 15px; margin-top: 13px;">
        <input type="text" id="in_search" style="outline: none; margin-right: 13px; margin-top: 13px;
        background-color: #EBEEF0; border: none; height: 15px; width: 290px; float: right" onFocus="inputChoice('search_lab', 'in_search', 'search_clear')" onblur="inputunChoice('search_lab', 'in_search', 'search_clear')" oninput="showClear('in_search', 'search_clear')">
        <button id="search_clear" class="SearchClear" onclick="clearInput('in_search')">
            <img src="../svg/iconmonstr-x-mark-thin.svg" height="12px" width="12px" style="margin-top: 1px;">
        </button>
    </label>

    <div style="height: 20px"></div>
<!--    推荐关注  -->
    <div class="OrderFollow">
<!--        第一行推荐关注-->
        <div class="FirstFloor">
            <span>推荐关注</span>
        </div>
<!--        这个是推荐关注-->
        <div class="Tuijian">
            <div>
                <div class="TJCard-Head"><img src="../svg/DemoPhoto.jpg" height="49" width="49"></div>
                <div class="TJCard-NamePad">
                    <span class="TJCard-Name">Outel Official</span>
                    <br>
                    <span class="TJCard-At">@RealOutel</span>
                </div>
                <div style="float: right">
                    <button class="TJCard-But">关注</button>
                </div>
            </div>
        </div>

        <%
            List<Dao.SQLVer> following = User.selectByID("following", request.getParameter("ID"));
            String [] followed = null;
            for(Dao.SQLVer info: following) {
                if(info.name.equals("following")) {
                    if(info.value.contains(",")) {
                        followed = info.value.substring(1).split(",");
                    }
                }
            }
            System.out.println("================> 输出推荐");
            List<List<Dao.SQLVer>> gets = GetUser.New();
            for(List<Dao.SQLVer> get: gets) {
                String profile = "";
                String name = "";
                String id = "";
                boolean isFollowed = false;
                for (Dao.SQLVer info : get) {
                    if (info.name.equals("profile")) {
                        profile = info.value;
                    }
                    if (info.name.equals("user_name")) {
                        name = info.value;
                    }
                    if (info.name.equals("user_id")) {
                        id = info.value;
                    }
                }
                // System.out.println(name + "/" + id);
                if(followed != null){
                    for (String idGet : followed) {
                        if (idGet.equals(id)) {
                            isFollowed = true;
                            break;
                        }
                    }
                }
                if(profile.equals("''")) {
                    profile = "/svg/def.png";
                }
                if (!name.equals("") && !id.equals(request.getParameter("ID"))) {
                    if(isFollowed) {
                        out.print("" +
                                "       <div class=\"Tuijian\">" +
                                "           <div>" +
                                "               <div class=\"TJCard-Head\"><img src=\"" + profile + "\" height=\"49\" width=\"49\"></div>" +
                                "               <div class=\"TJCard-NamePad\">" +
                                "                   <span class=\"TJCard-Name\">" + name + "</span>" +
                                "                   <br>" +
                                "                   <span class=\"TJCard-At\">@" + name + "</span>" +
                                "               </div>" +
                                "               <div style=\"float: right\">\n" +
                                "                    <button class=\"TJCard-But\" style=\"background: #1DA1F2;color: #FFFFFF;cursor:pointer;outline:none;\" onclick=\"window.location.href='/Follow?type=uf&follow=" + id + "&backto=/home/homeright.jsp?ID=" + request.getParameter("ID") + "'\">已关注</button>\n" +
                                "                </div>\n" +
                                "            </div>\n" +
                                "        </div>"
                        );
                    } else {
                        out.print("" +
                                "       <div class=\"Tuijian\">" +
                                "           <div>" +
                                "               <div class=\"TJCard-Head\"><img src=\"" + profile + "\" height=\"49\" width=\"49\"></div>" +
                                "               <div class=\"TJCard-NamePad\">" +
                                "                   <span class=\"TJCard-Name\">" + name + "</span>" +
                                "                   <br>" +
                                "                   <span class=\"TJCard-At\">@" + name + "</span>" +
                                "               </div>" +
                                "               <div style=\"float: right\">\n" +
                                "                    <button class=\"TJCard-But\" style=\"cursor:pointer;outline:none;\" onclick=\"window.location.href='/Follow?type=fl&follow=" + id + "&backto=/home/homeright.jsp?ID=" + request.getParameter("ID") + "'\">关注</button>\n" +
                                "                </div>\n" +
                                "            </div>\n" +
                                "        </div>"
                        );
                    }
                }
            }
        %>

    <div style="height: 50px">
        <div>
            <button style="outline:none; padding-top: 15px; padding-left: 15px; font-family: 'Microsoft YaHei'; color: #1DA1F2; border: none; background-color: #F7F9FA; font-size: 1rem;">
                显示更多
            </button>
        </div>
    </div>




</div>

<!--   末尾的落款 -->
    <div style="height: 15px"></div>
    <div class="LastFloor">
        <span>outel.chuhelan.com © 2020 - 2021</span>
        <br>
        <a href="https://beian.miit.gov.cn/#/Integrated/index" target="_blank">- 苏ICP备20015498号 -</a>
    </div>
</div>

<script src="home.js"></script>

</body>
</html>