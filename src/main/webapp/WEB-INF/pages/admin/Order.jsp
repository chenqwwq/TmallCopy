<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-21
  Time: 下午10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<%@include file="../public/admin/adminHeader.jsp"%>
<%@include file="../public/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>订单管理</title>
</head>
<body>
    <div class="workingArea">
        <span class="label label-info" >订单管理</span>
        <br>
        <br>
        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover1 table-condensed">
                <thead>
                    <tr class="success">
                        <th>ID</th>
                        <th>状态</th>
                        <th>金额</th>
                        <th>商品数量</th>
                        <th>买家名称</th>
                        <th>创建时间</th>
                        <th>支付时间</th>
                        <th>发货时间</th>
                        <th>确认收货时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderList}" var="order">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.statusDesc}</td>
                            <td>￥<fmt:formatNumber type="number" value="${order.total}" minFractionDigits="2"/></td>
                            <td align="center">${order.num}</td>
                            <td align="center">${order.user.name}</td>
                            <td><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${order.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${order.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${order.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>
                                <button class="orderPageCheckOrderItems btn btn-primary btn-xs">查看详情</button>
                                <c:if test="${order.status=='waitDelivery'}">
                                    <a href="orderDelivery?oid=${order.id}">
                                        <button class="btn btn-primary btn-xs">发货</button>
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                        <tr class="orderPageOrderItemTR"  oid=${order.id}>
                            <td colspan="10" align="center">
                            <div  class="orderPageOrderItem">
                            <table width="800px" align="center" class="orderPageOrderItemTable">
                            <c:forEach items="${order.orderItems}" var="oi">
                                <tr>
                                    <td align="left">
                                        <img width="40px" height="40px" src="/img/productSingle/${oi.product.firstProductImage.id}.jpg">
                                    </td>
                                    <td>
                                        <a href="product?pid=${oi.product.id}">
                                            <span>${oi.product.name}</span>
                                        </a>
                                    </td>
                                    <td align="right">
                                        <span class="text-muted">${oi.number}个</span>
                                    </td>
                                    <td align="right">
                                        <span class="text-muted">单价：￥${oi.product.promotePrice}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                            </table>
                            </div>
                        </tr>
                     </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
