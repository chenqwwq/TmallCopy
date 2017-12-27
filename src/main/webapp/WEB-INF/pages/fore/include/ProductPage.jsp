<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-12-20
  Time: 下午10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>模仿天猫官网 ${product.name}</title>
</head>
<body>
    <div class="category-picture-div">
        <img class="category-picture" src="img/category/${product.category.id}.jpg">
    </div>
    <div class="product-main-div">
        <div class="imgAndInfo">
            <!-- 左边大图以及缩略图 -->
            <div class="Img">
                <img class="product-big-img" src="img/productSingle/${product.firstProductImage.id}.jpg">
                <div class="product-small-img">
                    <c:forEach items="${product.singleImage}" var="sImg">
                        <img src="img/productSingle_small/${sImg.id}.jpg">
                    </c:forEach>
                </div>
            </div>
            <div class="info">
                <div class="product-name">
                    ${product.name}
                </div>
                <!-- 此处因为class重复导致bug,在以后尽量用多层选择器,精细化元素选择 -->
                <div class="product-subTitle-info">
                    ${product.subTitle}
                </div>
                <div class="product-price-div">
                    <div class="juhuasuan">
                        <span class="juhuasuan-title">聚划算</span>
                        <span>此商品即将参与聚划算,<span class="juhuasuan-time">1天19小时</span>后开始</span>
                    </div>

                    <div class="product-price">
                        <div class="gouwujuan-div">
                            <img height="16px" src="img/site/gouwujuan.png">
                            <span> 全天猫实物商品通用</span>
                        </div>
                        <div class="origin-price-div">
                            <span class="original-price-name">价格</span>
                            <span class="original-price">
                                ¥<fmt:formatNumber type="number" value="${product.originalPrice}" minFractionDigits="2"/>
                            </span>
                        </div>
                        <div class="promotion-price-div">
                            <span class="promotion-price-name">促销价 </span>
                            <span class="promotion-price">
                                ¥<fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/>
                            </span>
                        </div>
                    </div>
                </div>
                <!-- 数据获取bug -->
                <div class="product-count-div">
                    <div>销量 <span class="redColor boldWord"> ${product.saleCount }</span></div>
                    <div>累计评价 <span class="redColor boldWord"> ${product.reviewCount}</span></div>
                </div>
                <style type="text/css">

                </style>
                <div class="product-number">
                    <span>数量</span>
                    <span>
                        <span class="buy-number-span">
                            <input class="buy-number-input" type="text" value="1">
                        </span>

                        <span class="arrow">
                            <a href="#nowhere" class="increase-number">
                                <span class="updown">
                                    <img src="img/site/increase.png">
                                </span>
                            </a>

                            <!-- 中间隔离层 -->
                            <span class="updown-middle"></span>

                            <a href="#nowhere"  class="decrease-number">
                                <span class="updown">
                                    <img src="img/site/decrease.png">
                                </span>
                            </a>
                        </span>
                    件
                    </span>
                    <span>库存${product.stock}件</span>
                </div>
                <div class="service-commitment-div">
                    <span class="service-commitment-title">
                        服务承诺
                    </span>
                    <span class="service-commitment-link">
                        <a href="#nowhere">正品保证</a>
                        <a href="#nowhere">极速退款</a>
                        <a href="#nowhere">赠运险费</a>
                        <a href="#nowhere">七天无理由退换</a>
                    </span>
                </div>
                <div class="buy-div">
                    <button class="buy-button">立即购买</button>
                    <button class="add-cart-button"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button>
                </div>
            </div>
            <div style="clear: both"></div>
        </div>
        <div class="product-detailAndReview-div">
            <div class="product-title-div">
                <a href="#nowhere" class="selected" id="product-detail">商品详情</a>
                <a href="#nowhere" id="product-review">累计评价<span class="redColor">${product.reviewCount}</span></a>
            </div>
            <!-- 商品详情 -->
            <div class="product-detail-div">
                <div class="product-parameter-div">
                    <span class="product-parameter-title">
                        产品参数：
                    </span>
                    <div class="product-parameter-list">
                        <c:forEach items="${propertyValues}" var="pv">
                            <span>${pv.property.name}:  ${fn:substring(pv.value, 0, 10)} </span>
                        </c:forEach>
                    </div>
                    <div style="clear: both"></div>
                </div>
                <div class="product-detailImg-list">
                    <c:forEach items="${product.detailImage}" var="pi">
                        <img src="img/productDetail/${pi.id}.jpg">
                    </c:forEach>
                </div>
            </div>
            <!-- 评价模块 -->
            <div class="product-review-div" style="display: none">
                <c:if test="${empty reviews}">
                    <span class="no-review-prompt">暂无评论</span>
                </c:if>
                <c:if test="${!empty reviews}">
                    <c:forEach items="${reviews}" var="review">
                        <div class="product-review-item">
                            <div class="product-review-item-desc">
                                <div class="product-review-item-content">
                                        ${review.content }
                                </div>
                                <div class="product-review-item-time">
                                    <fmt:formatDate value="${review.createDate}" pattern="yyyy-MM-dd"/>
                                </div>
                            </div>
                            <div class="product-review-item-username">
                                <!-- 此处的匿名使用script转化 -->
                            </div>
                            <div style="clear:both"></div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
    <div style="clear: both"></div>
</body>
</html>
<script type="application/javascript">
    //script的返回值检测
    function checkLogin() {
        var res;
        $.ajax({
            type:'get',
            async:false,
            url:"/check_login",
            dataType:"text",
            success:function (result) {
                res = result;
                return result;
            }
        });
        return res;
    }
    $("button.buy-button").click(function () {
        alert("b:"+checkLogin())
//        $("div#login-modal").modal("show");
    });
</script>

