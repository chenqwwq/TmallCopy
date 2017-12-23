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
    <div class="categoryPictureInProductPageDiv">
        <img class="categoryPictureInProductPage" src="img/category/${product.category.id}.jpg">
        ${product.id}
    </div>
    <div id="imgAndInfo">
        <!-- 左边大图以及缩略图 -->
        <div id="img">
            <img src="img/productSingle/${product.firstProductImage.id}.jpg">
            <div class="smallImageDiv">
                <c:forEach items="${product.singleImage}" var="sImg">
                    <img src="img/productSingle_small/${sImg.id}.jpg">
                </c:forEach>
            </div>
        </div>
        <div id="info"></div>
    </div>
</body>
</html>
