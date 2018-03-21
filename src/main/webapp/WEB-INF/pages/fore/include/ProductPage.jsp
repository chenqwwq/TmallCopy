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
        <img class="category-picture" src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/category/${product.category.id}.jpg">
    </div>
    <div class="product-main-div">
        <div class="imgAndInfo">
            <!-- 左边大图以及缩略图 -->
            <div class="Img">
                <img class="product-big-img" src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/productSingle/${product.firstProductImage.id}.jpg">
                <div class="product-small-img">
                    <c:forEach items="${product.singleImage}" var="sImg">
                        <img src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/productSingle_small/${sImg.id}.jpg">
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
                            <img height="16px" src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/gouwujuan.png">
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
                    <div>销量 <span class="redColor boldWord"> ${product.saleCount}</span></div>
                    <div>累计评价 <span class="redColor boldWord"> ${product.reviewCount}</span></div>
                </div>
                <style type="text/css">

                </style>
                <div class="product-number">
                    <span>数量</span>
                    <span>
                        <span class="buy-number-span">
                            <input class="buy-number-input" value="1">
                        </span>

                        <span class="arrow">
                            <a href="#nowhere" class="increase-number">
                                <span class="updown">
                                    <img src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/increase.png">
                                </span>
                            </a>

                            <!-- 中间隔离层 -->
                            <span class="updown-middle"></span>

                            <a href="#nowhere"  class="decrease-number">
                                <span class="updown">
                                    <img src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/decrease.png">
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
                        <img src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/productDetail/${pi.id}.jpg">
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
$(function () {
    var big_img = $("div.Img img.product-big-img");
    var stock = ${product.stock};
    /**
     * 预览图切换的鼠标触发事件
     */
    $("div.product-small-img img").mouseenter(function () {
        // var name = $(this).attr("src").split("/")[2].split(".")[0];
        //获取原来的图片地址
        var oldSrc = $(this).attr("src");
        //替换src中的二级目录 构造新的图片地址
        var newSrc = oldSrc.replace("productSingle_small","productSingle");
        //替换大图的地址
        big_img.attr("src",newSrc);
    });
    /**
     * 添加增加/减少购买数量的箭头按钮的点击事件
     *          增加一个边界控制：
     *              不能大于库存
     *              不能小于0
     */
    var buyNumber_input = $("input.buy-number-input");
    $("span.arrow a.increase-number").click(function () {
        var des = parseInt(buyNumber_input.val()) + 1;
        buyNumber_input.val(des>stock?stock:des);
    });
    $("span.arrow a.decrease-number").click(function () {
        var des = parseInt(buyNumber_input.val()) - 1;
        buyNumber_input.val(des<1?1:des);
    });

    /**
     * 商品详情和商品评价的切换函数
     */
    $("div.product-title-div a").click(function () {
        //判断该元素是否具有selected属性
        if($(this).hasClass("selected"))
            return;
        //获取原selected的元素
        var selectA =$("div.product-title-div a.selected");
        //删除原元素的selected属性
        selectA.removeClass("selected");
        //构建需要显示的divId
        $("div."+selectA.attr("id")+"-div").hide();
        //为该元素加上selected属性
        $(this).addClass("selected");
        //显示对应的div
        $("div."+$(this).attr("id")+"-div").show();
    });

    /**
     * 购买数量的检查
     */
    var buyNum_input = $("input.buy-number-input");
    buyNum_input.change(function () {
        var buyNum = buyNum_input.val();
        buyNum = parseInt(buyNum);
        if(isNaN(buyNum))
            buyNum = 1;
        if(buyNum > stock)
            buyNum = stock;
        if(buyNum < 0)
            buyNum = 1;
        buyNum_input.val(buyNum);
    });

    /**
     * 立即购买的点击事件
     */
    $("button.buy-button").click(function () {
        if(checkLogin() === 'false')
            //如果没有登录则显示login-modal 县实现登录
            $("div#login-modal").modal('show');
        else{
            //在已经登录的情况下，开始进行购买操作
            //1、获取pid和num
            var pid = ${product.id};
            var num = $("input.buy-number-input").val();
            location.href = "buy?pid="+pid+"&num="+num;
        }
    });

    /**
     * 添加到购物车的点击事件
     */
    $("button.add-cart-button").click(function () {
        if(checkLogin() === 'false')
            $("div#login-modal").modal('show');
        else{
            //获取需要的数据
            var pid = ${product.id};
            var num = $("input.buy-number-input").val();
            //发送Ajax异步请求
            $.ajax({
                url:"addCart",
                type:"post",
                data:{
                    pid:pid,
                    num:num
                },
                success:function (result) {
                    if(result === 'success'){
                        alert("添加成功");
                    }else{
                        alert("添加失败");
                    }
                }
            });
        }
    });

});
</script>

