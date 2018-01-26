<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-30
  Time: 下午4:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<nav class="top">
    <a href="${contextPath}/home">
        <span style="color:#C40000;margin:0px" class="glyphicon glyphicon-home"></span>
        天猫首页
    </a>
    <span>喵，欢迎来天猫</span>
    <c:if test="${!empty user}">
        <a href="login.jsp">${user.name}</a>
        <a href="/logout">退出</a>
    </c:if>
    <c:if test="${empty user}">
        <a href="/login">请登录</a>
        <a href="/register">免费注册</a>
    </c:if>
    <!--
       .pull-right  元素向右边飘移
    -->
    <span class="pull-right">
            <a href="forebought">我的订单</a>
            <a href="cart">
            <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
            购物车<strong>${user.waitPayOrderCount}</strong>件</a>
        </span>
</nav>





