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
                            <img selectIt="false" class="cart-select-all" src="img/site/cartNotSelected.png">
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
                            <td class="cart-product-number">
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

    var _all = $("img.cart-select-img");
    var _select_all = $("img.cart-select-all");
    var _delete = $("a.cart-delete-orderItem");
    var _num_minus = $("a.number-minus");
    var _num_plus = $("a.number-plus");
    var _product_number = $("input.cart-orderItem-num");

    $(function () {
        /**
         * 在点击选择方面好像代码有点繁琐
         */
        /*
            商品全选动作
         */
        _select_all.click(function () {
            var _this = $(this);
            if(_this.attr("selectIt") === "false") {
               _all.attr("src", "img/site/cartSelected.png");
               _all.attr("selectIt","true");
               _this.attr("src","img/site/cartSelected.png");
               _this.attr("selectIt","true");
            }else{
               _all.attr("src","img/site/cartNotSelected.png");
               _all.attr("selectIt","false");
               _this.attr("src","img/site/cartNotSelected.png");
               _this.attr("selectIt","false");
            }
            syncSelect();
            syncPrice()
        });
        /*
          商品的选取动作
         */
       $("img.cart-select-img").click(function (){
           //变量替换获取
           var _this = $(this)
           if(_this.attr("selectIt") === "false"){
               _this.attr("src","img/site/cartSelected.png");
               _this.attr("selectIt","true");
           }
           else{
               _this.attr("src","img/site/cartNotSelected.png");
               _this.attr("selectIt","false");
           }
           //调用同步函数
           syncPrice();
           syncSelect();
           //同步全选
           checkSelect();
       });
       /**
        * 删除的点击事件
        */
       _delete.click(function () {

       });
       /**
        * 商品数目的点击事件
        * 边界判定和价格商品数目的同步留在input的点击事件
        */
       /**
        *  ...不知道为什么执行一次完整的响应过程会触发三次点击事件
        *       因为被选中商品的数量同步放在点击事件
        */
       _num_minus.click(function () {
           //确定需要改变的商品数目
           var num_ = $(this).siblings("input.cart-orderItem-num");
           num_.val(parseInt(num_.val()) - 1);
           //通过代码手动触发propertychange事件
           _product_number.trigger("change");
       });
       _num_plus.click(function () {
           var num_ = $(this).siblings("input.cart-orderItem-num");
           num_.val(parseInt(num_.val()) + 1);
           _product_number.trigger("change");
       });
       //input中的值的改变事件
        _product_number.on("change",function () {
            var value = $(this).val();
            if(value < 1 || isNaN(value)){
               $(this).val(1);
            }
        });
    });
    /**
     * 同步最后的结算价格
     * 直接遍历所有的选择图标
     */
    function syncPrice() {
        var sum = 0;
        _all.each(function () {
           if($(this).attr("selectIt") === "true"){
               /*
                * 此处使用个节点之间的关系来获取目标节点
                * 和直接定义class或者id对比，优劣未知
                */
               //因为页面中显示的价格已经转化为字符串 所以此时需要转变回数值
               var price = $(this).parent().nextAll(".cart-sumPrice-td").children("span.cart-product-sumPrice").text();
               price = price.replace(/￥/g,"");
               price = price.replace(/,/g,"");
               sum += Number(price);
           }
       });
       $("span.cartSumPrice").text("￥ "+sum);
    }

    /**
     * 同步选择的商品件数
     * 也是直接遍历所有选择图标
     */
    function syncSelect() {
        var sum = 0;
       _all.each(function () {
           if($(this).attr("selectIt") === "true"){
               var num = $(this).parent().nextAll(".cart-product-number").find("input.cart-orderItem-num").val();
               sum += Number(num);
           }
       });
       $("span.cartSumNumber").text(sum);
    }

    /**
     * 如果单个商品的取消，在所有商品取消完之后，全选跟着变
     * 反之也是
     */
    function checkSelect() {
        //赋予第一个的属性的值
        var flag = true;
        var first = _all.eq(0).attr("selectIt");
        _all.each(function () {
            //逐个比较
            if(first !== $(this).attr("selectIt")){
                flag = false;
                return false;
            }
        });
        //如果没有返回,则说明全部一致
        //全选选中
        if(flag){
            if(first  !== _select_all.attr("selectIt")){
                //代码触发点击事件
                _select_all.trigger("click");
            }
        }
    }
</script>
</html>
