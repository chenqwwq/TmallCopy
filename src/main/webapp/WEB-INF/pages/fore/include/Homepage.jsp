<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-12-3
  Time: 下午3:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <script src="/js/fore/Home.js"></script>
    </head>
    <img src="img/site/catear.png" id="catHead" class="catHead"/>
    <body>
        <!-- 水平菜单和轮播 -->
        <div class="CategoryAndCarousel">
            <div class="category">
                <div class="head">
                    <span style="margin-left:10px" class="glyphicon glyphicon-th-list"></span>
                    <span style="margin-left:10px" >商品分类</span>
                </div>
                <div class="rightMenu">
                    <span><a href=""><img src="/img/site/chaoshi.png"/></a></span>
                    <span><a href=""><img src="/img/site/guoji.png"/></a></span>
                    <c:forEach items="${categories}" var="category" varStatus="st">
                        <c:if test="${st.count <= 4}">
                            <span >
                                <!-- 需要改写 -->
                                <a href="nowhere" class="color-white">${category.name}</a>
                            </span>
                        </c:if>

                    </c:forEach>
                </div>
            </div>
            <div style="position: relative">
                <div class="categoryMenu">
                    <c:forEach items="${categories}" var="c">
                        <div class="one-category" id="categoury-${c.id}">
                            <span class="glyphicon glyphicon-link"></span>
                            <a href="forecategory?cid=${c.id}">
                                 ${c.name}
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <c:forEach items="${categories}" var="c">
                    <div class="product-subTitle" id="subTitle-${c.id}">
                        <c:forEach items="${c.groupProducts}" var="ps">
                            <div class="row">
                                <!-- 遍历所有该类型商品 -->
                                <c:forEach items="${ps}" var="p">
                                    <!-- 如果subTitle不为空 -->
                                    <c:if test="${!empty p.subTitle}">
                                          <c:forEach items="${fn:split(p.subTitle, ' ')}" var="title" varStatus="st">
                                              <a href="#nowhere">
                                                  ${title}
                                              </a>
                                          </c:forEach>
                                        <div class="seperator"></div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:forEach>

                    </div>
                </c:forEach>
                <script>
                    /**
                     *  随机出推荐商品
                     */
                    $("div.product-subTitle div.row a").each(function () {
                        if(Math.random() > 0.8)
                            $(this).css("color","#87CEFA");
                    });
                    /**
                     *  绑定鼠标进入和离开事件
                     *        显示商品
                     */
                    $("div.product-subTitle").each(function () {
                        $(this).mouseenter(function () {
                            $(this).show();
                        });
                        $(this).mouseleave(function () {
                            $(this).hide();
                        });
                    });
                    $("div.one-category").each(function () {
                        $(this).mouseenter(function () {
                            var element = "div#subTitle-"+$(this).attr("id").split("-")[1];
                            $(element).show();
                        });

                        $(this).mouseleave(function () {
                            var element = "div#subTitle-"+$(this).attr("id").split("-")[1];
                            $(element).hide();
                        });
                    });
                </script>
            </div>
            <div class="carouselBackgroundDiv">
            </div>
            <div id="carousel-of-product"  class="carousel-of-product carousel slide1" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-of-product" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-of-product" data-slide-to="1"></li>
                    <li data-target="#carousel-of-product" data-slide-to="2"></li>
                    <li data-target="#carousel-of-product" data-slide-to="3"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <img class="carousel carouselImage" src="img/lunbo/1.jpg" >
                    </div>
                    <div class="item">
                        <img  class="carouselImage" src="img/lunbo/2.jpg" >
                    </div>
                    <div class="item">
                        <img  class="carouselImage" src="img/lunbo/3.jpg" >
                    </div>
                    <div class="item">
                        <img  class="carouselImage" src="img/lunbo/4.jpg" >
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${empty param.categorycount}">
            <c:set var="categorycount" scope="page" value="100"/>
        </c:if>
        <c:if test="${!empty param.categorycount}">
            <c:set var="categorycount" scope="page" value="${param.categorycount}"/>
        </c:if>

        
        <div class="homepage-category-products">
                <c:forEach items="${categories}" var="c" varStatus="stc">
                <c:if test="${stc.count<=categorycount}">
                    <div class="one-category-product">
                        <div class="left-mark"></div>
                        <span class="category-title">
                                ${c.name}
                        </span>
                        <br>
                        <c:forEach items="${c.products}" var="p" varStatus="st">
                            <c:if test="${st.count<=5}">
                                <div class="one-product" >
                                    <a href="product?pid=${p.id}"><img width="100px" src="img/productSingle_middle/${p.firstProductImage.id}.jpg"></a>
                                    <a class="productItemDescLink" href="foreproduct?pid=${p.id}">
                                        <span class="productItemDesc">[热销]
                                            <!-- 截取name的前20个字符 -->
                                            ${fn:substring(p.name, 0, 20)}
                                        </span>
                                    </a>
                                    <span class="product-price">
                                        <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
                                    </span>
                                </div>
                            </c:if>
                        </c:forEach>
                        <div style="clear:both"></div>
                    </div>
                </c:if>
            </c:forEach>
            <img id="end-png" class="end-png" src="img/site/end.png">
        </div>
    </body>
</html>
