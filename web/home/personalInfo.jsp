<%@ page import="com.outside.outel.Util.URLTools" %>
<%@ page import="com.outside.outel.Dao.Dao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.outside.outel.Service.TokenPass" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.outside.outel.Dao.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8"%><!DOCTYPE html>

<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>我的 / Outel - 畅所欲言</title>
    <link rel="icon" href="icon.png" sizes="32x32">
    <link rel="stylesheet" href="personalInfo.css">
</head>

<%
    // 验证登录
    String id = "";
    String token = "";
    boolean noMe = false;
    String back = request.getParameter("back");
    if(back == null) {
        noMe = true;
        id = request.getParameter("id");
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
    // 获取个人信息
    List<Dao.SQLVer> List = User.selectByID("user_name,profile,following,follower,reg_time", id);// 处理时间
    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
    Date date = formatter.parse(List.get(4).value);
    formatter = new SimpleDateFormat("yyyy年MM月dd");
    String joinTime = formatter.format(date);
    // 计算关注数量
    int followingNum = 0;
    char []c=List.get(2).value.toCharArray();
    for (char value : c) {
        String cstr = String.valueOf(value);
        if (cstr.equals(",")) {
            followingNum++;
        }
    }
    // 计算关注数量
    int followerNum = 0;
    char []d=List.get(3).value.toCharArray();
    for (char value : d) {
        String cstr = String.valueOf(value);
        if (cstr.equals(",")) {
            followerNum++;
        }
    }

%>

<body>
    <div class="AboveAll">
<!--      这个是顶栏       -->
        <div class="topbar">
            <button><img src="../svg/personalInfo/backspace.svg"></button>
            <span><%out.print(List.get(0).value);%></span>
        </div>
<!--        这个是顶栏大图片-->
        <div class="TopBigImg">
            <img src="">
        </div>
<!--        个人信息的图片-->
        <div class="PersonalPic">
            <img src="<%out.print(List.get(1).value);%>" height="134">
        </div>
<!--        编辑个人资料-->
        <%
            List<Dao.SQLVer> infos = User.selectByID("following", request.getParameter("userid"));
            String following = "";
            for(Dao.SQLVer info: infos) {
                if(info.name.equals("following")) {
                    following = info.value;
                }
            }
            String[] infoFol = following.split(",");
            boolean hasFollowed = false;
            for(String ida: infoFol) {
                if(ida.equals(id)) {
                    hasFollowed = true;
                }
            }
            if(!hasFollowed) {
                out.print("<button class=\"SetPersonal\"");
            } else {
                out.print("<button class=\"SetPersonal_flo\"");
            }
            if(!noMe){
                out.print("onclick=\"window.parent.document.getElementById('Pan').style.visibility = 'visible';\"");
                out.print(">");
                out.print("            <span>编辑个人资料</span>");
            }else{
                if(hasFollowed) {
                    out.print("onclick=\"window.location.href='/Follow?type=uf&follow=" + id + "&backto=/home/personalInfo.jsp?id=" + id + "&userid=" + request.getParameter("userid") + "'\"");
                    out.print(">");
                    out.print("            <span>已关注</span>");
                } else {
                    out.print("onclick=\"window.location.href='/Follow?type=fl&follow=" + id + "&backto=/home/personalInfo.jsp?id=" + id + "&userid=" + request.getParameter("userid") + "'\"");
                    out.print(">");
                    out.print("            <span>关注</span>");
                }
            }
        %>
        </button>
<!--        个人资料栏-->
        <div class="BottomPersonal">
            <span style="font-family: 'Microsoft YaHei'; font-weight: bold; font-size: 1.2rem;">
                <%out.print(List.get(0).value);%>
            </span><br>
            <span style="font-family: 'Microsoft YaHei';color: #8393A1;">
                @<%out.print(List.get(0).value);%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </span>
            <img src="../svg/personalInfo/data.svg" height="18">
            <span style="color: #8393A1;">
                <%out.print(joinTime);%>
            </span>
            <span style="color: #8393A1;">
                加入
            </span><br>
            <span style="font-family: 'Microsoft YaHei'; font-weight: bold;line-height: 40px;">
                &nbsp;<%out.print(followingNum);%>
            </span>
            <span style="color: #8393A1;">
                正在关注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </span>
            <span style="font-family: 'Microsoft YaHei'; font-weight: bold;">
                &nbsp;<%out.print(followerNum);%>
            </span>
            <span style="color: #8393A1;">
                关注者
            </span>
        </div>

<!--        下面的选项卡 第二次写        -->
        <div id="div1">
            <button value="1" index="0" class="tab_checked">推文</button>
            <button value="2" index="1" class="tab_unchecked">喜欢</button>


<!--        内容一 发送的out           -->
            <div class="content2" style="display: block;">
                <iframe frameborder="no" scrolling="no" width="100%" onload="this.height=this.contentWindow.document.documentElement.scrollHeight;" src="<%out.print("tuiwen.jsp?id=" + id);%>"></iframe>
            </div>
<!--        内容二 喜欢的out           -->
            <div class="content2" id="if2">
                <iframe frameborder="no" scrolling="no" width="100%" onload="document.getElementById('if2').style.display='block';this.height=this.contentWindow.document.documentElement.scrollHeight;document.getElementById('if2').style.display='none';" src="<%out.print("like.jsp?id=" + id);%>"></iframe>
            </div>
        </div>
<!--     底边的文字           -->
        <div class="bottomDiv">
            <span>-我们也是有底线的-</span>
        </div>
    </div>


<script>
    window.onload=function(){
        var oDiv=document.getElementById('div1');
        var aBtn=oDiv.getElementsByTagName('button');
        var aDiv=oDiv.getElementsByTagName('div');

        for(var i=0;i<aBtn.length;i++){
            aBtn[i].index=i;
            aBtn[i].onclick=function(){
                for(var i=0;i<aBtn.length;i++){
                    aBtn[i].className='tab_unchecked';
                    aDiv[i].style.display='none';
                }
                this.className='tab_checked';
                aDiv[this.index].style.display='block';
            };
        }

    };
</script>

</body>
</html>