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
        </div>
        <!-- 用Ajax提交数据 此处的form仅仅作为前端框架需要 -->
        <form class="form-horizontal register-form">
            <div class="register-div">

                <div id="register-back" class="register-back alert alert-danger" style="display: none">
                </div>

                <div class="register-step-0 register-step">
                    <label for="register-username" class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-10">
                        <input id="register-username" class="form-control" placeholder="Enter Username">
                    </div>
                   <button id="register-btn-1" type="button" class="btn gray-btn">下一步</button>
                </div>

                <div class="register-step-1 register-step" style="display: none">
                    <label for="register-password" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-10">
                        <input id="register-password" type="password" class="form-control" placeholder="Enter Password">
                    </div>
                    <div style="margin-top: 20px;height: 60px"></div>
                    <label id="label-password-1" for="register-password-1" class="col-sm-2 control-label">确认密码</label>
                    <div class="col-sm-10">
                        <input id="register-password-1" type="password" class="form-control" placeholder="Enter to Submit">
                    </div>
                </div>

                <div class="register-step-2 alert alert-success" style="display: none">
                    恭喜，注册成功!!!
                    <br>
                    <a href="Home.jsp  ">跳转到首页</a>
                </div>
            </div>
            <script>
                var register_username =$("input#register-username");
                var register_btn_1 = $("button#register-btn-1");
                var register_back = $("div#register-back");
                var register_password = $("input#register-password");
                var register_password_1 = $("input#register-password-1");
                /**
                 * 密码输入
                 *      1.密码不为空
                 *      2.两次输入相等
                 *      3.Ajax向后台注册
                 */
                function registerCheck() {
                    var val = register_password.val();
                    var val1 = register_password_1.val();
                    if (val.length === 0 || val1.length === 0)
                        return;
                    if (val !== val1) {
                        register_back.show();
                        register_back.html('两次输入不一致!');
                    }else{
                        register_back.hide();
                        var name  = register_username.val();
                        $.ajax({
                            type:'post',
                            url:"/register",
                            data:{
                                name:name,
                                password:val
                            },
                            success:function (result) {
                                if(result.success){
                                    changeLiActive(2);
                                }
                                else{
                                    register_back.show();
                                    register_back.html("注册失败");
                                }

                            }
                        });
                    }
                }
                register_password.change(function () {
                    registerCheck();
                });
                register_password_1.change(function () {
                    registerCheck();
                });
                /**
                 * register-username的状态改变事件
                 *  在输入完成并验证成功之后改变按钮样子
                 */
                register_username.change(function () {
                    var name = $("input#register-username").val();
                    if(name.length > 0) {
                        //Ajax
                        $.ajax({
                            type: "post",
                            url: "/verify_register",
                            data: {
                                name: name
                            },
                            success: function (result) {
                                if (result.success) {
                                    //改变按钮的css
                                    register_btn_1.css("background-color","#ff4000");
                                    //添加触发事件
                                    register_btn_1.click(function () {
                                        changeLiActive(1);
                                    });
                                } else {
                                    //判断失败则显示back框
                                    register_back.show();
                                    register_back.html("用户名已存在!");
                                }
                            }
                        });
                    }else{
                        //修改按钮css
                        register_btn_1.css("background-color","#dedede");
                        register_btn_1.unbind('click');
                    }
                });
                /**
                 * 下一步按钮的点击事件
                 */
                function changeLiActive(num) {
                    //删除原来的active
                    $("ol.register-ol li.active").removeClass('active');
                    //新增active
                    $("ol.register-ol li").eq(num).addClass('active');
                    //隐藏所有div
                    $("div.register-div div.register-step").hide();
                    //显示目标div
                    var id = "div.register-step-"+num;      //构建id
                    $(id).show();
                }
            </script>
        </form>
    </body>
</html>
