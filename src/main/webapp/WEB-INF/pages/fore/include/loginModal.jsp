<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-12-26
  Time: 下午3:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../public/fore/Header.jsp"%>
<!--
    在后台的一些登录或者更改操作中也用到了模态框
    此处详细注释!
-->
<!--
    modal是模态框的主要class属性
    fade是模态框淡入淡出的动画效果
    role="dialog"表示模态框的以对话框形式显示
-->
<div class="modal fade" id="login-modal" role="dialog" tabindex="-1" aria-labelledby="login-modal">
    <!-- 从dialog层才能设定模态框的大大小 -->
    <div class="modal-dialog" role="document" id="login-modal-top-div">
        <!-- 主体内容 -->
        <div class="modal-content">
            <div class="modal-header">
                <h3>登录界面</h3>
            </div>
            <div class="modal-body">
                <div class="alert alert-danger" style="display: none">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                    <span class="error-msg"></span>
                </div>
                <div class="login-input-div">
                    <div class="input-group">
                        <label for="login-modal-name" class="input-group-addon">
                            <span class=" glyphicon glyphicon-user"></span>
                        </label>
                        <input id="login-modal-name" class="form-control login-input" placeholder="手机/会员名/邮箱">
                    </div>
                    <br/>
                    <div class="input-group">
                        <label for="login-modal-password" class="input-group-addon">
                            <span class=" glyphicon glyphicon-lock"></span>
                        </label>
                        <input id="login-modal-password" class="form-control login-input" type="password" placeholder="密码">
                    </div>
                    <button class="login-btn btn btn-default">登 录</button>
                </div>
            </div>
            <div class="modal-footer">
                <div class="login-link">
                    <a>忘记密码</a>
                    <a>忘记用户名</a>
                    <a href="register">免费注册</a>
                </div>
            </div>
            <script type="application/javascript">
                $("div.login-input-div button.login-btn").click(function () {
                    var username = $("input#login-modal-name").val();
                    var word = $("input#login-modal-password").val();
                    //检验输入
                    if(username.length === 0 || word === 0){
                        $("div#login-modal span.error-msg").html("请输入账号密码");
                        $("div#login-modal div.alert").show();
                        return false;
                    }
                    //发送Ajax请求
                    $.ajax({
                        url:"/login_ajax",
                        type:'post',
                        data:{
                            name:username,
                            password:word
                        },
                        success:function (result) {
                            if (result.success) {
                                /**
                                 * 登录成功之后的操作
                                 * 暂时定为刷新本页面
                                 */
                                window.location.reload();
                            } else {
                                //登录失败
                                /**
                                 * 显示错误提示
                                 */
                                $("div#login-modal span.error-msg").html(result.inf);
                                $("div#login-modal div.alert").show();
                            }
                        }
                    });
                });
            </script>
        </div>
    </div>
</div>
