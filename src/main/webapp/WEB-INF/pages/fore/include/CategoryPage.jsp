<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-12-27
  Time: 下午6:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${category.name}</title>
</head>
<body>
    <div class="category-page-div">
        <div class="category-picture-div">
            <img src="img/category/${category.id}.jpg">
        </div>
        <div class="category-sort-div">
            <table class="category-sort-table">
                <tr>
                    <td <c:if test="${'all'==param.sort||empty param.sort}">class="grayColumn"</c:if> >
                        <a href="?cid=${category.id}&sort=all">
                            综合
                            <span class="glyphicon glyphicon-arrow-down"></span>
                        </a>
                    </td>
                    <td <c:if test="${'review'==param.sort}">class="grayColumn"</c:if> >
                        <a href="?cid=${category.id}&sort=review">
                            人气
                            <span class="glyphicon glyphicon-arrow-down"></span>
                        </a>
                    </td>
                    <td <c:if test="${'date'==param.sort}">class="grayColumn"</c:if>>
                        <a href="?cid=${category.id}&sort=date">
                            新品
                            <span class="glyphicon glyphicon-arrow-down"></span>
                        </a>
                    </td>
                    <td <c:if test="${'saleCount'==param.sort}">class="grayColumn"</c:if>>
                        <a href="?cid=${category.id}&sort=saleCount">
                            销量
                            <span class="glyphicon glyphicon-arrow-down"></span>
                        </a>
                    </td>
                    <!-- price为升序  -->
                    <td <c:if test="${'priceAsc'==param.sort || 'priceDes' == param.sort}">class="grayColumn"</c:if>>
                        <c:choose>
                            <c:when test="${'priceAsc' == param.sort}">
                                <a href="?cid=${category.id}&sort=priceDes">
                                    价格
                                    <span class="glyphicon glyphicon-resize-vertical"></span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="?cid=${category.id}&sort=priceAsc">
                                    价格
                                    <span class="glyphicon glyphicon-resize-vertical"></span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
            <table class="category-sort-table">
                <tr>
                    <td><input class="sort-price begin-price" placeholder="请输入"></td>
                    <td class="grayColumn price-middle-column">-</td>
                    <td><input class="sort-price end-price" placeholder="请输入"></td>
                </tr>
            </table>
        </div>
        <div class="category-products-div">
            <c:forEach items="${category.products}" var="product">
                <div class="product-template-div">
                    <img src="img/productSingle_middle/${product.firstProductImage.id}.jpg">
                    <span class="product-price">¥<fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/></span>
                    <a class="product-link productItemDescLink" href="product?pid=${product.id}">
                        <span>${fn:substring(product.name, 0, 50)}</span>
                    </a>
                    <a  class="tmall-link " href="product?pid=${product.id}">
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
    </div>
</body>
</html>
