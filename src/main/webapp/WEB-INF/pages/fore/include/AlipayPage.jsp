<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-2-22
  Time: 下午2:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>支付页面</title>
</head>
<body>
<div class="alipay-div">
    <div class="alipay-Logo">
        <img class="pull-left" src="img/site/simpleLogo.png">
        <div style="clear:both"></div>
    </div>

    <div class="confirm-money-div">
        <span class="confirm-money-tip">扫一扫付款（元）</span>
        <br>
        <span class="confirm-money-num">
        ￥<fmt:formatNumber type="number" value="${param.total}" minFractionDigits="2"/></span>
    </div>
    <div>
        <img class="alipay-img" src="img/site/alipay2wei.png">
    </div>

    <div>
        <a href="payed?orderId=${param.oid}&total=${param.total}"><button class="confirmPay">确认支付</button></a>
    </div>

</div>
</body>
</html>
