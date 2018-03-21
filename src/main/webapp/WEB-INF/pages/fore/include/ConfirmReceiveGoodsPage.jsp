<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-3-8
  Time: 下午1:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>确认收货页面</title>
</head>
<body>
    <div class="ConfirmReceiveGoodsPage">
        <div class="confirmReceiveImageDiv">
            <img src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/comformPayFlow.png">
            <div  class="confirmPayTime1">
                <fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </div>
            <div  class="confirmPayTime2">
                <fmt:formatDate value="${order.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </div>
            <div class="confirmPayTime3">
                yyyy-MM-dd HH:mm:ss
            </div>
        </div>
        <!-- Order的一些信息 -->
        <div class="orderInfo-div">
            <!-- 标题 -->
            <div class="orderInfo-text">订单信息</div>
            <!-- 订单包含的orderItem -->
            <table class="order-OrderItem-table">
                <thead>
                    <th colspan="2">宝贝</th>
                    <th width="120px">单价</th>
                    <th width="120px">数量</th>
                    <th width="120px">商品总价 </th>
                    <th width="120px">运费</th>
                </thead>
                <!-- 遍历并查看 OrderItem -->
                <tbody>
                    <c:forEach items="${order.orderItems}" var="oi">
                        <tr>
                            <td><img width="50px" src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
                            <td class="orderItem-link">
                                <a href="product?pid=${oi.product.id}">${oi.product.name}</a>
                            </td>
                            <td>￥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/></td>
                            <td>1</td>
                            <td><span class="orderItem-price">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></span></td>
                            <td><span>快递 ： 0.00 </span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="orderInfo-text pull-right">
                实付款： <span class="orderItem-total">￥<fmt:formatNumber type="number" value="${order.total}" minFractionDigits="2"/></span>
            </div>
            <div style="clear: both"></div>
            <div class="orderOtherInfo-div">
                <table class="orderOtherInfo-table">
                    <tr>
                        <td>订单编号：</td>
                        <td>${order.orderCode} <img width="23px" src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/confirmOrderTmall.png"></td>
                    </tr>
                    <tr>
                        <td>卖家昵称：</td>
                        <td>天猫商铺 <span class="wangwangGif1"></span></td>
                    </tr>
                    <tr>
                        <td>收货信息： </td>
                        <td>${order.address}，${order.receiver}， ${order.mobile}，${order.post} </td>
                    </tr>
                    <tr>
                        <td>成交时间：</td>
                        <td><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="confirmReceive-last-div">
            <div class="confirmWarning">请收到货后，再确认收货！否则您可能钱货两空！</div>
            <a href="confirmReceipt?oid=${order.id}"><button class="confirmReceive-button btn">确认支付</button></a>
        </div>
    </div>
</body>
</html>
<script type="application/javascript">
    s
</script>
