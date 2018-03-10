<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-3-9
  Time: 上午10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>评价页面</title>
</head>
<body>
    <div class="Review-div">
        <div class="productInfo-div">
            <div class="productInfoImg-div">
                <img width="400px" height="400px" src="img/productSingle/${product.firstProductImage.id}.jpg" >
            </div>
            <div class="productInfoText-div">
                <div class="productInfoText-name">
                    ${product.name}
                </div>
                <table class="productInfoText-table">
                    <tr>
                        <td width="75px">
                            价格:
                        </td>
                        <td>
                            <span class="productInfoText-price">
                                ￥<fmt:formatNumber type="number" minFractionDigits="2" value="${product.originalPrice}"/>
                            </span>
                            元
                        </td>
                    </tr>
                    <tr>
                        <td>配送</td>
                        <td>快递:  0.00</td>
                    </tr>
                    <tr>
                        <td>月销量:</td>
                        <td>
                            <span class="productInfoText-saleCount">${product.saleCount}</span>件
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="clear: both"></div>
        <div class="review-div">
            <div class="reviewTitle">
                <div class="reviewTitle-text">
                    累计评价<span class="reviewTitle-number"> ${product.reviewCount}</span>
                </div>
            </div>
            <!-- 默认情况下不显示全部评论 -->
            <c:if test="${param.showOnly==true}">
                <div class="reviewList-div">
                    <c:forEach items="${reviews}" var="r">
                        <div class="reviewList-foreach">
                            <div class="reviewUserName">${r.user.anonymousName}<span class="reviewUserInfoAnonymous">匿名用户:</span></div>
                            <div class="reviewContent">${r.content}</div>
                            <div class="reviewDate pull-right"><fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd"/></div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${param.showOnly!=true}">
                <div class="addReview-div">
                    <form method="post" action="doReview">
                        <div class="addReview-Text">其他买家，需要你的建议哦！</div>
                        <table class="addReview-table">
                            <tr>
                                <td class="addReview-td">评价商品</td>
                                <td><textarea name="content"></textarea></td>
                            </tr>
                        </table>
                        <div class="addReviewButton-div">
                            <input type="hidden" name="oid" value="${order.id}">
                            <input type="hidden" name="pid" value="${product.id}">
                            <button type="submit" >提交评价</button>
                        </div>
                    </form>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
