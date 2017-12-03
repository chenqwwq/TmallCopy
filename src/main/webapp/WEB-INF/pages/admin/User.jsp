<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-21
  Time: 下午8:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<%@include file="../public/admin/adminHeader.jsp"%>
<%@include file="../public/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>用户界面</title>
</head>
<body>
    <div class="workingArea">
        <span class="label label-info" >用户管理</span>
        <br>
        <br>
        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover  table-condensed">
                <thead>
                    <tr>
                        <td style="width: 30%">ID</td>
                        <td style="width: 50%">用户名称</td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${userList}" var="user">
                        <tr>
                            <td>
                                ${user.id}
                            </td>
                            <td>
                                ${user.name}
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="pageDiv">
        <%@include file="../public/admin/adminPage.jsp"%>
    </div>
</body>
</html>
