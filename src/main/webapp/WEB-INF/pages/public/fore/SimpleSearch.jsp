<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-12-9
  Time: 下午4:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="simpleSearchOutDiv">
    <a href="${contextPath}">
        <img id="simpleLogo" class="simpleLogo" src="https://chenbxxx.oss-cn-beijing.aliyuncs.com/tmallCopy_images/site/simpleLogo.png">
    </a>

    <form action="search">
        <div class="simpleSearchDiv pull-right">
            <input placeholder="平衡车 原汁机" name="keyword">
            <button class="searchButton" style="font-weight: bold">搜天猫</button>
            <div class="searchBelow">
                <c:forEach items="${categories}" var="c" varStatus="st">
                    <c:if test="${st.count>=8 and st.count<=11}">
                    <span>
                        <a href="category?cid=${c.id}">
                                ${c.name}
                        </a>
                        <c:if test="${st.count!=11}">
                            <span>|</span>
                        </c:if>
                    </span>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </form>
    <div style="clear:both"></div>
</div>
