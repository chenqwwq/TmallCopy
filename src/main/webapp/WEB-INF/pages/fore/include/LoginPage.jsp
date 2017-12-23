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
    <style type="text/css">
        div#login-div{
            position: relative;
        }
        img#loginBackgroundImg{
            display: block;
            margin: 0px auto;
            width: 100%;
        }
        div.simpleLogo{
            margin-top: 40px;
            margin-bottom: 40px;
            margin-left: 100px;
        }
        div#login-div-inside{
            width: 400px;
            height: 500px;
            position: absolute;
            right: 60px;
            top: 120px;
            background-color: white ;
            z-index: 1;
        }
        span#login-title{
            margin-top: 35px;
            display:inline-block;
            margin-left:30px;
            font-size:16px;
            font-weight:bold;
        }
        /*div.login-input-div label{*/
            /*width: 40px;*/
            /*height: 40px;*/
            /*text-align: center;*/
            /*background-color: #ddd;*/
            /*margin-left: 30px;*/
            /*margin-top: 25px;*/
            /*margin-bottom: 0;*/
        /*}*/
        div.login-input-div div.input-group label span{
            font-size: 20px;
        }
        div.login-input-div div.input-group input{
            height: 47px;
        }
        div.login-input-div {
            margin-left: 30px;
            margin-right: 30px;
            margin-top: 30px;
        }
        button.login-btn{
            background-color: #ff0036;
            width: 100%;
            height: 47px;
            margin-top: 30px;
            color: white;
            font-weight: 500;
            font-size: 19px;
        }
        div.login-link{
            text-align: right;
            margin-top: 40px;
            margin-right: 20px;
        }
        div.login-link a{
            margin-right: 5px;
            margin-left: 5px;
        }
    </style>
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
            <a href="${contextPath}"><img src="img/site/simpleLogo.png"></a>
        </div>

        <img id="loginBackgroundImg" class="loginBackgroundImg" src="img/site/loginBackground.png">

        <form class="login-form" action="/login" method="post">
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
                        <input id="login-name" class="form-control" name="name" placeholder="手机/会员名/邮箱" type="text">
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
                    <a href="/register">免费注册</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
