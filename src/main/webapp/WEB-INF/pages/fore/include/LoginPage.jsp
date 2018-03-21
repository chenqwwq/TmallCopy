<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-12-16
  Time: 下午6:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>登录界面</title>
    <script>
        $(function () {
            //如果msg对象不为空表示登录失败
            //将msg显示到error-div中
            var error_div = $("div#login-error-div");
            var error_span = $("span#login-error-span");
            <c:if test="${! empty msg}">
                error_div.show();
                error_span.html(${msg});
            </c:if>

            //form提交前的检查工作
            $("form.login-form").submit(function () {
                if(0 == $("input#login-name").val().length||0 ==$("input#login-password").val().length){
                    $("span#login-error-span").html("请输入账号密码");
                    $("div#login-error-div").show();
                    return false;
                }
                return true;
            });
        });
    </script>
</head>
<body>
    <div id="login-div">
        <div class="simpleLogo">
            <a href="${contextPath}"><img src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/simpleLogo.png"></a>
        </div>

        <img id="loginBackgroundImg" class="loginBackgroundImg" src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/loginBackground.png">

        <form class="login-form" action="login" method="post">
            <div id="login-div-inside">
                <div id="login-error-div" class="alert alert-danger" style="display: none" role="alert">
                    <span id="login-error-span">
                            ${msg}
                    </span>
                </div>

                <span id="login-title">天猫登录</span>

                <div class="login-input-div">
                    <div class="input-group">
                        <label for="login-name" class="input-group-addon">
                            <span class=" glyphicon glyphicon-user"></span>
                        </label>
                        <input id="login-name" class="form-control login-input" name="name" placeholder="手机/会员名/邮箱">
                    </div>
                    <br/>
                    <div class="input-group">
                        <label for="login-password" class="input-group-addon">
                            <span class=" glyphicon glyphicon-lock"></span>
                        </label>
                        <input id="login-password" name="password" class="form-control" type="password" placeholder="密码">
                    </div>
                    <button class="login-btn btn btn-default">登 录</button>
                </div>
                <div class="login-link">
                    <a>忘记密码</a>
                    <a>忘记用户名</a>
                    <a href="register">免费注册</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
