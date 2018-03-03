<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-3-3
  Time: 下午2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单</title>
</head>
<body>
    <div class="bought-div">
        <div class="bought-orderType">
            <div class="select-orderType"><a >所有订单</a></div>
            <div><a>待付款</a></div>
            <div><a>待发货</a></div>
            <div><a>待收货</a></div>
            <div><a class="noRight-a">待评价</a></div>
            <div class="orderTypeLastOne">
                <a class="noRight-a"></a>
            </div>
        </div>
        <div style="clear:both"></div>
        <div class="orderList-title">
            <table class="orderList-title-table">
                <tr>
                    <td>宝贝</td>
                    <td width="100px">单价</td>
                    <td width="100px">数量</td>
                    <td width="120px">实付款</td>
                    <td width="100px">交易操作</td>
                </tr>
            </table>
        </div>
        <div class="orderList-item">
            <c:forEach items="${orders}" var="order">
                <table class="orderList-item-table">
                    <tr class="orderListItemFirstTR">
                        <!-- 此处显示订单号码 以及一些功能图标 -->
                        <td colspan="2">
                            <b><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
                            <span>订单号: ${order.orderCode}</span>
                        </td>
                        <td  colspan="2"><img width="13px" src="img/site/orderItemTmall.png">天猫商场</td>
                        <td colspan="1">
                            <a class="wangwanglink" href="#nowhere">
                                <div class="orderItemWangWangGif"></div>
                            </a>
                        </td>
                        <td class="orderItem-delete-td">
                            <a class="deleteOrderLink" oid="${order.id}" href="#nowhere">
                                <span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
                            </a>
                        </td>
                    </tr>
                    <c:forEach items="${orderItems}" var="orderItem" varStatus="vs">
                        <!-- 遍历Order中的OrderItems属性, 显示图片,名称,价格等-->
                        <tr></tr>
                    </c:forEach>
                </table>
            </c:forEach>
        </div>
    </div>
</body>
</html>
