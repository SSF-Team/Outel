<%@ page import="com.outside.outel.Dao.Dao" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.outside.outel.Service.GetUser" %>
<%@ page import="com.outside.outel.Service.PrintHTML" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>探索 / Outel-畅所欲言</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="css/notifications.css">
    <link rel="stylesheet" href="css/homeright.css">
</head>
<body>
<!--    这是最大的一个div-->
<div class="BiggestDiv">
    <div class="TopBar" style="border-bottom:  1px solid #EBEEF0;">
        <span>探索</span>
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
        System.out.println("================> 输出所有用户");
        List<List<Dao.SQLVer>> gets = GetUser.All();
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
            if (followed != null) {
                for (String idGet : followed) {
                    if (idGet.equals(id)) {
                        isFollowed = true;
                        break;
                    }
                }
            }
            if (profile.equals("''")) {
                profile = "/svg/def.png";
            }
            if (!name.equals("") && !id.equals(request.getParameter("ID")) && !isFollowed) {
                out.print(PrintHTML.UserCard(
                        name,
                        name,
                        profile,
                        id,
                        "/home/explore.jsp?ID=" + request.getParameter("ID"),
                        "560",
                        isFollowed
                ));
            }

        }
    %>

</div>
</body>
</html>