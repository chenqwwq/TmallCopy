    <%--
      Created by IntelliJ IDEA.
      User: chen
      Date: 17-12-9
      Time: 下午4:15
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
    <head>
        <title>注册界面</title>
        <style type="text/css">
            div.register-div{
                width: 100%;
            }
            table.register-table{
                margin: 0 auto;
            }
            .bottom-line{
                width: 25%;
                display: inline-block;
                line-height: 47px;
                text-align: center;
                font-weight: bold;
                font-size: 18px;
                color: #999 ;
            }
            div.register-progress ol.register-ol{
                width: 80%;
                margin: 0 20%;
                padding-left:0;
            }
            div.register-progress{
                border-bottom: 3px solid #e6e6e6;
                width: 60%;
                height: 50px;
                position: relative;
                margin: 0 auto;
            }
            div.register-progress ol .active{
                border-bottom: 3px solid #ff4700;
                color: black;
            }
        </style>
    </head>
    <body>
        <div class="register-progress">
            <ol class="register-ol">
                <li class="bottom-line active">
                   <span class="register-top">设置用户名</span>
                </li>
                <span class=" glyphicon glyphicon-chevron-right" style="color: #C40000"></span>
                <li class="bottom-line">
                    <span class="register-top">设置登录密码</span>
                </li>
                <span class=" glyphicon glyphicon-chevron-right" style="color: #C40000"></span>
                <li class="bottom-line">
                    <span class="register-top">注册成功</span>
                </li>
            </ol>
            <%--<div class="bottom-line"></div>--%>
            <%--<div class="bottom-line register-top">--%>
                <%--<span>1.设置用户名</span>--%>
            <%--</div>--%>
            <%--<div class="bottom-line register-top">--%>
                <%--<span>2.输入并确认密码</span>--%>
                <%--&lt;%&ndash;&ndash;%&gt;--%>
            <%--</div>--%>
            <%--<div class="bottom-line register-top">--%>
                <%--<span>3.注册成功</span>--%>
                <%--&lt;%&ndash;3.注册成功&ndash;%&gt;--%>
            <%--</div>--%>
            <%--<div class="bottom-line"></div>--%>
        </div>
        <form method="post" action="registerUser" id="register-form">
            <div class="register-div">
                <table class="register-table">
                    <tr>
                        <td>
                            <label for="register-username-input">用户名</label>
                        </td>
                        <td>
                            <input id="register-username-input"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="register-password-input">登录密码</label>
                        </td>
                        <td>
                            <input id="register-password-input" type="password">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="register-password-2-input">密码确认</label>
                       </td>
                        <td>
                            <input id="register-password-2-input" type="password">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">提 交</td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>
