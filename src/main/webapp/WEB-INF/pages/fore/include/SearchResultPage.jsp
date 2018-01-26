<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-12-30
  Time: 下午6:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>
        ${param.keyword}
    </title>
</head>
<body>
    <div class="search-result-div">
        <c:choose>
            <c:when test="${empty products}">
                <div class="empty-result-div">
                    <span>
                        没有找到满足条件的商品
                    </span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="show-result-div">
                    <c:forEach items="${products}" var="product">
                        <div class="product-template-div">
                            <img src="img/productSingle_middle/${product.firstProductImage.id}.jpg">
                            <span class="product-price">¥<fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/></span>
                            <a class="product-link" href="/product?pid=${product.id}">
                                    ${fn:substring(product.name, 0, 50)}
                            </a>
                            <a  class="tmall-link" href="/product?pid=${product.id}">
                                天猫专卖
                            </a>
                            <div class="show1 product-info">
                                <span class="month-sale-count ">月成交 <span class="productDealNumber">${product.saleCount}笔</span></span>
                                <span class="product-review">评价<span class="productReviewNumber"> ${product.reviewCount}</span></span>
                                <span class="wangwang">
                            <a class="wangwanglink" href="#nowhere">
                                <img src="img/site/wangwang.png">
                            </a>
                        </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
