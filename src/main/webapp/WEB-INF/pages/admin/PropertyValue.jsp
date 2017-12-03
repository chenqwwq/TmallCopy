<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-18
  Time: 下午1:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<%@include file="../public/admin/adminHeader.jsp"%>
<%@include file="../public/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>编辑属性</title>
    <style type="text/css">
        div.propertyValue-table-div{
            max-height:400px;
            overflow: auto;
        }
        div#tempId{
            position: absolute;
            top: 200px;
            right:200px;
            height:50px;
            width: 200px;
        }
    </style>
</head>
<body>
    <div class="workingArea">
        <ol class="breadcrumb">
            <li><a href="/admin/category">所有分类</a></li>    <!-- 跳到分类页面 -->
            <li><a href="product?cid=${product.category.id}">${product.category.name}</a></li>    <!-- 本页面 -->
            <li class="active">属性管理</li>
        </ol>
        <div class="alert alert-info" role="alert" id="tempId">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            请直接的输入框内修改
        </div>
        <div class="propertyValue-table-div">
            <table style="width: 100%" class="table table-striped table-hover table-condensed">
                <c:forEach items="${propertyValues}" var="pv">
                    <tr>
                        <td width="300px">
                            <label for="pvValue-${pv.id}">
                                    ${pv.property.name}
                            </label>
                        </td>
                        <td>
                            <input style="width: 300px" id="pvValue-${pv.id}" value="${pv.value}" class="propertyValue-input">
                        </td>
                    </tr>
                 </c:forEach>
            </table>
        </div>
    </div>

<script>
    $(function () {
        var str;
        //增加撤销修改按钮的点击事件
        $("button#revoke-btn").click(function () {
            //撤销修改操作
            //简单的就是重定向到该页面
            window.location.href="/admin/propertyValue?pid=${product.id}"
        });

        $("input.propertyValue-input").focus(function () {
            str = $(this).val();
        });

        /**
         * 在输入框失去焦点的时候触发该事件，利用ajax向后台发送数据
         *      并处理结果
         */
        $("input.propertyValue-input").blur(function () {
            //获取输入的值
            var val;
            //在内容没有改变的时候 直接return
            if(str === (val = $(this).val()))
                return;
            //获取id,在按照‘-’分割之后实在第二个字符串
            var pv_id = $(this).attr("id").split("-")[1];
            $.ajax({
                type:'post',
                data:{
                    _method:"put",
                    id:pv_id,
                    value:val
                },
                success:function (result) {
                    ResultHandler(result);
                },
                error:function () {
                    console.log("系统错误");
                }
            });
        });
    });

</script>


</body>
</html>
