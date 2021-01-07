<%@ page import="com.outside.outel.Dao.Dao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.outside.outel.Dao.Article" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="com.outside.outel.Service.PrintHTML" %>

<%@ page contentType="text/html; charset=UTF-8"%>

<%
    String id = request.getParameter("id");
%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="css/homeindex.css">
</head>
<body>

<%
    // 输出纯文本 Out
    // 查询数据
    List<List<Dao.SQLVer>> infos = Article.selectAll("article_id,text,author_id,view_num,post_num,liker,article_time,article_del");
    System.out.println("================> 所有文章 - PSINFO");
    for(List<Dao.SQLVer> info: infos) {
        for (Dao.SQLVer art : info) {
            System.out.print(art.name + " - " + art.value + " / ");
        }
        System.out.println();
    }
    // 按时间排序（冒泡）
    int i, j;
    for(i=0; i<infos.size(); i++) {
        for (j = 1; j < infos.size() - i; j++) {
            if (Integer.parseInt(infos.get(j - 1).get(6).value.trim()) < Integer.parseInt(infos.get(j).get(6).value.trim())) {
                Collections.swap(infos, j - 1, j);
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
        // 判断是否喜欢过，计算喜欢数量
        boolean isLike = false;
        int likeNum = 0;
        if(infos.get(i).get(5).value.contains(",")) {
            String[] likes = infos.get(i).get(5).value.trim().split(",");
            likeNum = likes.length - 1;
            for(String str: likes) {
                if(str.equals(id)) {
                    isLike = true;
                    break;
                }
            }
        }
        System.out.println("> " + infos.get(i).get(2).value.trim() + " / " + id);
        if (infos.get(i).get(2).value.trim().equals(id)) {
            // 处理时间
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
            Date date = formatter.parse(infos.get(i).get(6).value.trim());

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            Calendar calendarNow = Calendar.getInstance();
            calendarNow.setTime(new Date());

            String dateShow = "";
            if (calendar.get(Calendar.YEAR) == calendarNow.get(Calendar.YEAR)) {
                if (calendar.get(Calendar.MONTH) == calendarNow.get(Calendar.MONTH)) {
                    if (calendarNow.get(Calendar.DATE) - calendar.get(Calendar.DATE) == 0) {
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
            for (Dao.SQLVer info : userInfo) {
                if (info.name.equals("user_name")) {
                    userName = info.value;
                }
                if (info.name.equals("profile")) {
                    profile = info.value;
                }
                if (info.name.equals("certification")) {
                    certification = info.value;
                }
            }
            out.print(PrintHTML.SmallOut(
                    userName,
                    userName,
                    dateShow,
                    infos.get(i).get(1).value.trim(),
                    "",
                    "0,0," + likeNum,
                    profile,
                    "/home/tuiwen.jsp?id=" + id,
                    infos.get(i).get(2).value.trim(),
                    id,
                    infos.get(i).get(0).value.trim(),
                    certification.equals("1"),
                    false,
                    isLike,
                    false
            ));
        }
    }
%>

</body>
</html>