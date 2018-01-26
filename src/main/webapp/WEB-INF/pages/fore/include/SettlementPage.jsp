<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-1-12
  Time: 下午4:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>结算页面</title>
</head>
<body>
    <div class="settlement-div">
        <!-- 此处用表单提交 -->
        <form method="post">
            <div class="buyFlow">
                <img class="pull-left" src="img/site/simpleLogo.png">
                <img class="pull-right" style="margin-right: 80px" src="img/site/buyflow.png">
                <div style="clear:both"></div>
            </div>
            <div class="address">
                <div class="address-tip">请输入收货地址</div>
                <div>
                    <table class="address-table">
                        <tr>
                            <td>
                                详细地址<span class="redColor">*</span>
                            </td>
                            <td>
                                <textarea name="address" placeholder="建议您如实填写详细收货地址，例如接到名称，门牌好吗，楼层和房间号等信息"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>邮政编码</td>
                            <td>
                                <input name="post" placeholder="如不清楚,可不用填写或直接填写000000"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                收货人姓名<span class="redColor">*</span>
                            </td>
                            <td>
                                <input name="receiver" placeholder="请输入正确的姓名!"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                手机号码<span class="redColor">*</span>
                            </td>
                            <td>
                                <input name="mobile" placeholder="请输入正确的11位手机!"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="product-info">
                <div class="product-info-tip">确认订单信息</div>
                <table class="product-info-table">
                    <thead>
                        <tr>
                            <th colspan="2" style="width: 50%">
                                <img class="tmall-buy" src="img/site/tmallbuy.png">
                                <a class="market-link" href="#nowhere">店铺：天猫店铺</a>
                                <a class="wangwanglink" href="#nowhere"> <span class="wangwangGif"></span> </a>
                            </th>
                            <th style="width:10%;">单价</th>
                            <th style="width:10%;">数量</th>
                            <th style="width:10%;">小计</th>
                            <th style="width:20%;">配送方式</th>
                        </tr>
                    </thead>
                    <tbody class="product-table-tbody">
                        <c:forEach items="${orderItems}" var="oi" varStatus="st" >
                            <tr class="orderItem-tr">
                                <td class="orderItem-td">
                                    <img class="orderItem-img" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg">
                                </td>
                                <td class="orderItem-product-name">
                                    <a  href="product?pid=${oi.product.id}">
                                            ${oi.product.name}
                                    </a>
                                    <br/>
                                    <img src="img/site/creditcard.png" title="支持信用卡支付">
                                    <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                    <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                </td>
                                <td>
                                    <span class="orderItem-product-price">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></span>
                                </td>
                                <td>
                                    <span class="orderItem-product-number">${oi.number}</span>
                                </td>
                                <td>
                                    <span class="orderItem-sum">￥
                                        <fmt:formatNumber type="number" value="${oi.number*oi.product.promotePrice}" minFractionDigits="2"/>
                                    </span>
                                </td>
                                <c:if test="${st.count==1}">
                                    <td>
                                        <label>
                                            <input type="radio">
                                            普通配送
                                        </label>
                                        <select class="orderItem-delivery-select" class="form-control">
                                            <option>快递 免邮费</option>
                                        </select>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="orderItem-sum-div">
                    <div class="pull-left">
                        <span class="leave-message">
                            给卖家留言：
                        </span>
                        <span>
                            <img class="leaveMessageImg" src="img/site/leaveMessage.png">
                        </span>
                        <span class="leaveMessage-textarea-span" style="display: none">
                            <textarea></textarea>
                        </span>
                    </div>
                    <div class="pull-right">
                       <span>
                           店铺合计(含运费): ￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/>
                       </span>
                    </div>
                </div>
            </div>
            <div class="submit-order-div">
                <span>实付款：</span>
                <span class="orderItem-total-sum-span">￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
                <br/>
                <button class="submit-order-button btn default-btn">提交订单</button>
            </div>
        </form>
    </div>
    <script type="text/javascript">
        /**
         * 1、图片和输入框的切换
         */
        $(function () {
            var leaveMessageImg = $("img.leaveMessageImg");
            var textarea_span = $("span.leaveMessage-textarea-span");
            var orderItem_sum_div = $("div.orderItem-sum-div");
            var textarea = $("span.leaveMessage-textarea-span textarea");
            /**
             *  切换img和textarea的函数
             */
            function settlement_toggle() {
                leaveMessageImg.toggle();
                textarea_span.toggle();
                //得到数值且不带单位
                if(orderItem_sum_div.height() === "80"){
                    orderItem_sum_div.height("30px");
                }else{
                    orderItem_sum_div.height("80px");
                }
            }
            /**
             *  在获得焦点的时候改变函数
             */
            leaveMessageImg.click(function () {
                //调用切换事件
                settlement_toggle();
                //textarea获取焦点
                textarea.focus();
                //绑定失去焦点的触发事件
                textarea.blur(function () {
                    settlement_toggle();
                });
            });
        })
    </script>
</body>
</html>
