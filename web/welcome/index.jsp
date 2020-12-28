<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="UTF-8">
    <title>Outel</title>
    <link rel="icon" href="../icon.png" sizes="32x32">

    <!-- 响应式触发 -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- 样式表 -->
    <link href="../bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../css/font-awesome.min.css">
    <link href="welcome.css" rel="stylesheet" type="text/css" id="colorCSS"/>
</head>

<script type="text/javascript">
    // 判断系统是否在暗黑模式下并替换对应 CSS
    window.onload = function(){
        const css = document.getElementById("colorCSS");
        if(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            css.setAttribute("href","welcome_dark.css");
        } else {
            css.setAttribute("href","welcome.css");
        }
    }
</script>

<body>

<iframe width="100%" height="100%" src="../index.html"></iframe>

<!-- 登录窗口 -->
<div class="overlay">
    <div class="card cardMain">
        <div id="topBarLogin" style="text-align: center;">
            <form action="../HerPass" method="post" style="width: 100%;" onsubmit="return checkForm();">
                <div style="text-align: left;margin-left: 50px;margin-right: 50px;">
                    <img src="../svg/outel_no_c.svg" style="height: 35px;margin-top: 45px;"/>
                    <input type="submit" value="下一步" class="btn btn-primary nextBut"/>
                </div>
                <div style="margin: 50px;text-align: left;">
                    <font style="font-size: 25px;" class="fontBold">选择你的头像！</font><br>
                    <div class="input-group mb-3">
                        <label class="herLab">
                            <div id="labBg">
                                <i class="fa fa-camera" aria-hidden="true" style="font-size: 30px;"></i>
                            </div>
                            <input accept="image/*" id="upload_file" type="file" style="visibility: hidden" onchange="imgChange(this);">
                        </label>
                        <input type="text" style="visibility: hidden;width: 0;" name="img" id="pImg" value="ERR">
                        <font style="font-size: 14px;font-family: 'Microsoft YaHei';margin: auto;margin-top: 70px;">任何人都可以在 Outel 产品中看到您的个人资料照片。 <a href="../privacy/index.html" target="_black">了解详情</a></font>
                    </div>
                </div>
            </form>
        </div>
    </div>


    <%
        String type = request.getParameter("err");
        if(type != null) {
            if(!type.isEmpty()) {
                out.print(
                        "<div id=\"toastOut\" aria-live=\"polite\" aria-atomic=\"true\" style=\"height: 100%;\">\n" +
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

</div>


<script>
    // 代理提交事件
    function checkForm(){
        return true;
    }


    // 图片选择事件
    function imgChange(img) {
        const reader = new FileReader();
        reader.onload = function (ev) {
            const imgFile = ev.target.result; //这是 Base64
            if(imgFile.substring(0, 11) !== "data:image/") {
                window.location.href="index.jsp?err=这不是个图片！";
                return;
            } else {
                try {
                    document.getElementById("toastOut").style.visibility = "hidden";
                } catch (e) {}
            }
            const lab = document.getElementById("labBg");
            lab.style.backgroundImage = "url(\"" + imgFile + "\")";
            document.getElementById("pImg").value = imgFile;
        }
        reader.readAsDataURL(img.files[0]);
    }
</script>

<script src="../bootstrap/bootstrap.min.js"></script>

</body>
</html>