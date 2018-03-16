<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-2-25
  Time: 下午4:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>支付成功</title>
</head>
<body>
    <div class="payed-div">
        <div class="payed-tip">
            <img src="img/site/paySuccess.png">
            <span>您已成功付款</span>
        </div>
        <div class="payed-addressInfo">
            <ul>
				<li>收货地址：${order.address} ${order.receiver} ${order.mobile }</li>
				<li>实付款：<span class="payed-price">
					￥<fmt:formatNumber type="number" value="${param.total}" minFractionDigits="2"/>
				</li>
				<li>预计08月08日送达	</li>
			</ul>

			<div class="check-link-div">
				您可以
				<a class="payed-check-link" href="bought">查看已买到的宝贝</a>
				<a class="payed-check-link" href="bought">查看交易详情 </a>
			</div>
        </div>
		<div class="payed-interval-line"></div>
		<div class="payed-warning-div">
			<img src="img/site/warning.png">
			<b>安全提醒：</b>下单后，<span class="redColor boldWord">用QQ给您发送链接办理退款的都是骗子！</span>天猫不存在系统升级，订单异常等问题，谨防假冒客服电话诈骗！
		</div>
    </div>
</body>
</html>
