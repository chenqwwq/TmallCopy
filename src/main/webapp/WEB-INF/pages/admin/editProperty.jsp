<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-4
  Time: 下午9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑属性</title>
    <%@include file="../public/adminHeader.jsp"%>
    <%@include file="../public/adminNavigator.jsp"%>
</head>
<body>
    <div class="workingArea">
        <ol class="breadcrumb">
            <li><a href="/admin/category">所有分类</a></li>    <!-- 跳到分类页面 -->
            <li><a href="${category.id}">${category.name}</a></li>    <!-- 本页面 -->
            <li class="active">属性管理</li>
        </ol>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover  table-condensed">
                <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>属性名称</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${properties}" var="p">

                    <tr>
                        <td>${p.id}</td>
                        <td>${p.name}</td>
                        <td>
                            <a href="admin_property_edit?id=${p.id}">
                                <span class="glyphicon glyphicon-edit"></span>
                            </a>
                        </td>
                        <td>
                            <a id="delete_property" dataId=${p.id}>
                                <span class="     glyphicon glyphicon-trash"></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="pageDiv">
            <%@include file="../public/adminPage.jsp"%>
        </div>
    </div>
</body>
<script type="text/javascript">
    $("a#delete_property").click(function () {
        $.ajax({
            type:"POST",
            data:{
                pid:$(this).attr('dataId'),
                _method:'DELETE'
            },
            success:function (result) {
                DeleteResultHandler(result);
            },
            error:function () {
                alert("系统错误")
            }
        });
    });
</script>
</html>
