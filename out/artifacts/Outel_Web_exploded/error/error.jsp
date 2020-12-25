<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="com.outside.outel.ToolClass.errType"%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>发生错误 / Outel</title>
    <link rel="stylesheet" href="error.css" id="colorCSS">
</head>

<script type="text/javascript">
    // 判断系统是否在暗黑模式下并替换对应 CSS
    window.onload = function(){
        const css = document.getElementById("colorCSS");
        if(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            css.setAttribute("href","error_dark.css");
        } else {
            css.setAttribute("href","error.css");
        }
    }
</script>

<body>
<div class="topbar">&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="../svg/outel_no_white.svg"  height="16px">&nbsp;&nbsp;
    发生错误
</div>
<div class="tophome">
    <div style="padding: 60px;padding-left: 120px;">
        <font style="font-size: 55px;font-family: 'Microsoft YaHei';font-weight: bold;">
        <%
            String type = request.getParameter("type");
            out.print(type);
        %>
        </font>
        <font style="font-size: 25px;font-family: 'Microsoft YaHei UI';margin-left: 51px;">
            <%
                errType err = new errType();
                out.print(err.getErr(type)[0] + "<br>");
            %>
        </font>
        <div style="margin-top: 30px;"></div>
        <font style="margin-left: 170px;font-size: 20px;">
            <%
                out.print(err.getErr(type)[1] + "<br>");
            %>
        </font>
        <div style="margin-top: 30px;"></div>
        <font style="margin-left: 170px;font-size: 15px;">
            <%
                String errmsg = request.getParameter("err");
                out.print(errmsg);
            %>
        </font>
    </div>
</div>
</body>
</html>