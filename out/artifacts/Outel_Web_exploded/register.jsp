<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>注册 Outel / Outel</title>
    <link rel="icon" href="icon.png" sizes="32x32">

    <!-- 响应式触发 -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 样式表 -->
    <link href="bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/main.css" rel="stylesheet" type="text/css" id="colorCSS"/>
    <link rel="stylesheet" href="css/font-awesome.min.css">
</head>

<script type="text/javascript">
    // 判断系统是否在暗黑模式下并替换对应 CSS
    window.onload = function(){
        const css = document.getElementById("colorCSS");
        if(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            css.setAttribute("href","css/main_dark.css");
        } else {
            css.setAttribute("href","css/main.css");
        }
    }
</script>

<body>

    <iframe width="100%" height="100%" src="index.html"></iframe>

    <!-- 注册窗口 -->
    <div class="overlay" id="regPan">
        <div class="card cardReg">
            <div id="topBarLogin" style="text-align: center;">
                <img src="svg/outel_no_c.svg" style="height: 35px;margin-top: 45px;"/>
                <div style="margin: 50px;text-align: left;margin-top: 30px;">
                    <font style="font-size: 25px;" class="fontBold">要一起来一杯吗？</font><br><div class="input-group mb-3">
                    <form action="RegPass" method="post" style="width: 100%;">
                        <label id="labRegName" class="inputLab">
                            <font id="titRegName" style="font-size: 13px;">用户名（昵称）</font>
                            <input name="name" style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labRegName', 'titRegName')" onFocus="inputChoice('labRegName', 'titRegName')"

                            <%
                                String name = request.getParameter("name");
                                if(name != null) {
                                    out.print("value=\"" + name + "\"");
                                }
                            %>

                            >
                        </label>
                        <label id="labRegMail" class="inputLab">
                            <font id="titRegMail" style="font-size: 13px;">邮箱</font>
                            <input name="email" style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labRegMail', 'titRegMail')" onFocus="inputChoice('labRegMail', 'titRegMail')"

                            <%
                            String email = request.getParameter("email");
                            if(email != null) {
                                out.print("value=\"" + email + "\"");
                            }
                            %>

                            >
                        </label>
                        <label id="labRegPass" class="inputLab">
                            <font id="titRegPass" style="font-size: 13px;">密码</font>
                            <input name="password" type="password" style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labRegPass', 'titRegPass')" onFocus="inputChoice('labRegPass', 'titRegPass')">
                        </label>
                        <div style="margin-top: 25px;padding: 5px;">
                            <font style="font-size: 14px;font-family: 'Microsoft YaHei'">注册即表示你同意 <a href="privacy/index.html" target="_black">隐私政策</a>，包括 Cookie 的使用。其他人将能够通过电子邮件或手机号码找到你。</font>
                        </div>
                        <input type="submit" value="注册" class="btn btn-primary" style="width: 100%;background-color: #53a1ff;border: 1px;border-radius: 20px;border-color: #69ADFF;margin-top: 15px;height: 45px;">
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%
    String type = request.getParameter("err");
    if(type != null) {
        if(!type.isEmpty()) {
            out.print(
                    "<div aria-live=\"polite\" aria-atomic=\"true\" style=\"height: 100%;\">\n" +
                    "        <div class=\"toast show toastMain\">\n" +
                    "            <div class=\"toast-body toastBody\">\n" +
                    "                " + type + "\n" +
                    "            </div>\n" +
                    "        </div>\n" +
                    "    </div>"
                     );
        }
    }
    %>

    <script src="bootstrap/bootstrap.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>