<%@ page import="com.outside.outel.Dao.Dao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="com.outside.outel.Dao.Article" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.outside.outel.Dao.Reply" %>
<%@ page import="com.outside.outel.Service.PrintHTML" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>Out / Outel-畅所欲言</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="css/notifications.css">
    <link rel="stylesheet" href="css/homeright.css">
</head>

<%
    // 获取文章信息
    List<Dao.SQLVer> infos = Article.selectByArtID("article_id,text,author_id,view_num,post_num,liker,article_time,article_del", request.getParameter("status"));
    String artid = "";
    String things = "";
    String author = "0";
    String view = "0";
    String post = "0";
    String liker = "";
    String time = "";
    String del = "";
    for(Dao.SQLVer info: infos) {
        if(info.name.equals("article_id")) {
            artid = info.value;
        }
        if(info.name.equals("text")) {
            things = info.value;
        }
        if(info.name.equals("author_id")) {
            author = info.value;
        }
        if(info.name.equals("view_num")) {
            view = info.value;
        }
        if(info.name.equals("post_num")) {
            post = info.value;
        }
        if(info.name.equals("liker")) {
            liker = info.value;
        }
        if(info.name.equals("article_time")) {
            time = info.value;
        }
        if(info.name.equals("article_del")) {
            del = info.value;
        }
    }
    if(post.equals("")) {
        post = "0";
    }
    if(view.equals("")) {
        view = "0";
    }
    // 判断是否喜欢过，计算喜欢数量
    boolean isLike = false;
    int likeNum = 0;
    if(liker.contains(",")) {
        String[] likes = liker.split(",");
        likeNum = likes.length - 1;
        for(String str: likes) {
            if(str.equals(author)) {
                isLike = true;
                break;
            }
        }
    }
    // 处理时间
    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
    Date date = formatter.parse(time);

    Calendar calendar = Calendar.getInstance();
    calendar.setTime(date);
    Calendar calendarNow = Calendar.getInstance();
    calendarNow.setTime(new Date());
    time = calendar.get(Calendar.YEAR) + "年" + (calendar.get(Calendar.MONTH) + 1) + "月" + calendar.get(Calendar.DATE) + "日";
    // 获取用户信息
    List<Dao.SQLVer> userInfo = User.selectByID("user_name,profile", author);
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
    // 关注链接
    String likeLink = "";
    if(isLike) {
        likeLink = "/Like?type=unlike&artid=" + artid + "&backto=/home/?status=" + artid;
    } else {
        likeLink = "/Like?type=like&artid=" + artid + "&backto=/home/?status=" + artid;
    }
%>

<body>
<!--    这是最大的一个div-->
<div class="BiggestDiv">
    <div class="TopBar" style="border-bottom:  1px solid #EBEEF0;">
        <span>Out</span>
    </div>


    <div class="Tuijian_a" style="width: 560px;">
        <div>
            <div class="TJCard-Head"><img src="<%out.print(profile);%>" height="49" width="49"></div>
            <div class="TJCard-NamePad">
                <span class="TJCard-Name"><%out.print(userName);%></span>
                <br>
                <span class="TJCard-At">@<%out.print(userName);%></span><br>
            </div>
            <div style="padding-top: 70px;">
                <span class="TJCard-Index"><%out.print(things);%></span>
                <div style="padding-top: 20px;">
                    <span class="TJCard-Time" style="margin-top: 20px;"><%out.print(time);%> · Outel Web</span>
                </div>
            </div>
        </div>
    </div>
    <div class="Tuijian_a" style="width: 560px;height: 26px;line-height: 26px;">
        <span class="TJCard-Time" style="margin-top: 20px;height: 26px;font-size: 1.05rem;"><%out.print(post);%> 转发&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%out.print(likeNum);%> 喜欢</span>
    </div>
    <div class="Tuijian_a" style="width: 560px;height: 26px;line-height: 26px;">
        <div>
            <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;cursor: pointer;width: 130px;">
                <img src="../svg/pinglun.svg" height="22">
            </button>
            <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;cursor: pointer;width: 130px;">
                <img src="../svg/zhuantui.svg" height="22">
            </button>
            <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;cursor: pointer;width: 130px;" onclick="window.parent.location.href='<%out.print(likeLink);%>'">
                <img src="<%out.print(isLike?"../svg/xihuan_checked.svg":"../svg/xihuan.svg");%>" height="22">
            </button>
            <button style="padding: 0;margin: 0;border: 0;background-color: transparent;outline: none;cursor: pointer;width: 130px;">
                <img src="../svg/fenxiang.svg" height="22">
            </button>
        </div>
    </div>

    <%
        // 获取回复
        List<Dao.SQLVer> infoRep = Reply.selectByArtID("comment,create_by,create_time", artid);
        String comment = "";
        String creater = "";
        String timeRep = "";
        for(Dao.SQLVer info: infoRep) {
            if(info.name.equals("comment")) {
                comment = info.value;
            }
            if(info.name.equals("create_by")) {

                creater = info.value;
            }
            if(info.name.equals("create_time")) {
                timeRep = info.value;
            }
        }
        // 获取用户信息
        List<Dao.SQLVer> infoUser = User.selectByID("profile,user_name", creater);
        String profileRep = "";
        String name = "";
        for(Dao.SQLVer info: infoUser) {
            if(info.name.equals("profile")) {
                profileRep = info.value;
            }
            if(info.name.equals("user_name")) {
                name = info.value;
            }
        }
        if(comment != "") {
            out.print(PrintHTML.ReplyOut(name, userName, profileRep, comment));
        }
    %>

</div>
</body>
</html>