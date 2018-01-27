<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-1-23
  Time: 上午11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车界面</title>
</head>
<body>
    <div class="cart-div">
        <div class="cart-products-div">
            <table class="cart-products-table">
                <thead>
                    <tr>
                        <th class="selectAndImage">
                            <img selectIt="false" class="select-all cart-select-img" src="img/site/cartNotSelected.png">
                            全选
                        </th>
                        <th>商品信息</th>
                        <th>单价</th>
                        <th>数量</th>
                        <th width="120px">金额</th>
                        <th class="operation">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderItems}" var="orderItem">
                        <tr class="cart-product-tr">
                            <td>
                                <img selectIt="false" class="cart-select-img" src="img/site/cartNotSelected.png">
                                <a style="display:none" href="#nowhere"><img src="img/site/cartSelected.png"></a>
                                <img class="cart-product-img"  src="img/productSingle_middle/${orderItem.product.firstProductImage.id}.jpg">
                            </td>
                            <td style="width: 500px">
                                <div class="cart-product-link-div">
                                    <a href="product?pid=${orderItem.product.id}" class="cart-product-link">${orderItem.product.name}</a>
                                    <div class="cartProductLinkInnerDiv">
                                        <img src="img/site/creditcard.png" title="支持信用卡支付">
                                        <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                        <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="cart-product-original-price">￥${orderItem.product.originalPrice}</span>
                                <span  class="cart-product-promote-price">￥${orderItem.product.promotePrice}</span>
                            </td>
                            <td>
                                <div class="cart-product-number-change-div">
                                    <%--<span class="hidden orderItemStock " pid="${orderItem.product.id}">${orderItem.product.stock}</span>--%>
                                    <%--<span class="hidden orderItemPromotePrice " pid="${orderItem.product.id}">${orderItem.product.promotePrice}</span>--%>
                                    <a class="number-minus" href="#nowhere">-</a>
                                    <input class="cart-orderItem-num" autocomplete="off" value="${orderItem.number}">
                                    <a class="number-plus" href="#nowhere">+</a>
                                </div>
                            </td>
                            <td class="cart-sumPrice-td">
                                <span class="cart-product-sumPrice">￥<fmt:formatNumber type="number" value="${orderItem.product.promotePrice*orderItem.number}" minFractionDigits="2"/></span>
                            </td>
                            <td>
                                <a class="cart-delete-orderItem" href="#nowhere">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="cart-foot">
           <div class="pull-right">
               <span>已选商品 <span class="cartSumNumber" >0</span> 件</span>
               <span>合计 (不含运费): </span>
               <span class="cartSumPrice" >￥0.00</span>
               <button class="createOrderButton">结  算</button>
           </div>
        </div>
    </div>
</body>
<script type="text/javascript">
    $(function () {
        //商品的选取动作
       $("img.cart-select-img").click(function (){
           var resu = $(this).parent().nextAll(".cart-sumPrice-td").children("span.cart-product-sumPrice").text()
           var str = resu.substr(1);
           alert(str)
           alert("价格为："+Number(str));
           //变量替换获取
           var _this = $(this);
           var _all = $("img.cart-select-img");
           //1、判断selectIt的属性值
           if(_this.attr("selectIt") === "false"){
               //2、判断是否为全选
               if(_this.hasClass("select-all")) {
                   _all.attr("src", "img/site/cartSelected.png");
                   _all.attr("selectIt","true");
                   //全部价格累计
                   var sum;
                   _all.each(function () {
                       var sum2 = $(this).parent().nextAll(".cart-sumPrice-td").children("span.cart-product-sumPrice");
                   })
               }else{
                   _this.attr("src","img/site/cartSelected.png");
                   _this.attr("selectIt","true");
               }
           }
           else{
               if(_this.hasClass("select-all")){
                   _all.attr("src","img/site/cartNotSelected.png");
                   _all.attr("selectIt","true");
               }
               else{
                   _this.attr("src","img/site/cartNotSelected.png");
                   _this.attr("selectIt","false");
               }
           }
       });
    })
</script>
</html>
