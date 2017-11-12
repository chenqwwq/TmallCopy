<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-12
  Time: 下午4:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<%@include file="../public/adminHeader.jsp"%>
<%@include file="../public/adminNavigator.jsp"%>
<html>
<head>
    <title>产品图片管理</title>
</head>
<body>
    <div class="workingArea">
        <!-- 面包屑导航 -->
        <ol class="breadcrumb">
            <li><a href="${basePath}/admin/category">所有分类</a></li>
            <li><a href="${basePath}/admin/product?cid=${product.category.id}">${product.category.name}</a></li>
            <li><a href="${basePath}/admin/productImage?pid=${product.id}">${product.name}</a></li>
            <li class="active">产品图片管理</li>
        </ol>
    </div>
</body>
</html>
