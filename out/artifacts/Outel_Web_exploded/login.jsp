<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>登录 Outel / Outel</title>
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


<!-- 登录窗口 -->
<div class="overlay" id="loginPan">
    <div class="card cardLogin">
        <div id="topBarLogin" style="text-align: center;">
            <img src="svg/outel_no_c.svg" style="height: 35px;margin-top: 45px;"/>
            <div style="margin: 50px;text-align: left;margin-top: 65px;">
                <font style="font-size: 25px;" class="fontBold">欢迎回来，朋友！</font><br><div class="input-group mb-3">
                <form action="LoginPass" method="post" onsubmit="return checkForm();" style="width: 100%;">
                    <label id="labName" class="inputLab" style="margin-top: 30px;">
                        <font id="titName" style="font-size: 13px;">邮件地址</font>
                        <input name="account" type="email" id="acc" style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labName', 'titName')" onFocus="inputChoice('labName', 'titName')"

                            <%
                            String em = request.getParameter("email");
                            if(em != null) {
                                out.print("value=\"" + em + "\"");
                            }
                            %>

                        >
                    </label>
                    <label id="labPass" class="inputLab">
                        <font id="titPass" style="font-size: 13px;">密码</font>
                        <input name="password" type="password" id="pwd" style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labPass', 'titPass')" onFocus="inputChoice('labPass', 'titPass')">
                    </label>
                    <input name="type" type="type" style="display: none" value="login">
                    <input type="submit" value="登录" class="btn btn-primary" style="width: 100%;background-color: #53a1ff;border: 1px;border-radius: 20px;border-color: #69ADFF;height: 45px;margin-top: 25px;"/>
                </form>
                <br><br>
                <div style="height: 20px;text-align: center;width: 100%;margin-top:25px;">
                    <a href="#" style="font-size: 14px;">忘记密码</a> · <a href="#" style="font-size: 14px;">注册 Outel</a>
                </div>
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

    <script>
        // 输入加密
        function checkForm(){
            var pwd= document.getElementById('pwd');
            //pwd.value= md5(pwd.value);
            return true;
        }
    </script>

    <script src="bootstrap/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script src="js/md5.js"></script>

</body>
</html>