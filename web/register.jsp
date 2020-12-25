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
                    <label id="labRegName" class="inputLab">
                        <font id="titRegName" style="font-size: 13px;">用户名</font>
                        <input style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labRegName', 'titRegName')" onFocus="inputChoice('labRegName', 'titRegName')">
                    </label>
                    <label id="labRegMail" class="inputLab">
                        <font id="titRegMail" style="font-size: 13px;">邮箱</font>
                        <input style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labRegMail', 'titRegMail')" onFocus="inputChoice('labRegMail', 'titRegMail')">
                    </label>
                    <label id="labRegPass" class="inputLab">
                        <font id="titRegPass" style="font-size: 13px;">密码</font>
                        <input type="password" style="width: 100%;height: 30px;border: 0;outline: 0;" onblur="inputunChoice('labRegPass', 'titRegPass')" onFocus="inputChoice('labRegPass', 'titRegPass')">
                    </label>
                    <div style="margin-top: 25px;padding: 5px;">
                        <font style="font-size: 14px;font-family: 'Microsoft YaHei'">注册即表示你同意 <a href="privacy/index.html" target="_black">隐私政策</a>，包括 Cookie 的使用。其他人将能够通过电子邮件或手机号码找到你。</font>
                    </div>
                    <button type="button" class="btn btn-primary" style="width: 100%;background-color: #53a1ff;border: 1;border-radius: 20px;border-color: #69ADFF;margin-top: 15px;height: 45px;">
                        <font style="font-size: 18px;font-family: 'Microsoft YaHei';font-weight: bold;">注册</font>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="bootstrap/bootstrap.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>