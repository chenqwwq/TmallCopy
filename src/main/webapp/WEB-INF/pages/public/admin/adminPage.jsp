<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-2
  Time: 上午9:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $(function(){
        $("ul.pagination li.disabled a").click(function(){
            return false;
        });
    });
   <%
        /**
        *   重构request的param序列 直接?start的方式会丢失原参数
        */
        StringBuilder append = new StringBuilder("?");
        if(request.getQueryString() != null){
            String[] s = request.getQueryString().split("&");
            for (int i = 0;i < s.length;i++){
                if(s[i].startsWith("start")){
                    s[i] = "";       //将start参数重置
                }
            }
            for (String t : s){
                if(!t.equals(""))
                    append.append(t).append("&");       //重构基础参数
            }
        }
   %>


</script>

<nav>
    <ul class="pagination">
        <!-- if判断该页面是否有上一页,如果没有则增加属性disable -->
        <li <c:if test="${!page.hasPreviouse()}">class="disabled"</c:if>>
            <a href="<%=append.toString()%>start=0" aria-label="Previous" >
                <span>«</span>
            </a>
        </li>

        <li <c:if test="${!page.hasPreviouse()}">class="disabled"</c:if>>
            <a href="<%=append.toString()%>start=${page.start-page.count}" aria-label="Previous" >
                <span>‹</span>
            </a>
        </li>

        <c:forEach begin="0" end="${page.getTotalPage()-1}" varStatus="status">

            <c:if test="${status.count*page.count-page.start<=20 && status.count*page.count-page.start>=-10}">
                <li <c:if test="${status.index*page.count==page.start}">class="disabled"</c:if>>
                    <a
                            href="<%=append.toString()%>start=${status.index*page.count}"
                            <c:if test="${status.index*page.count==page.start}">class="current"</c:if>
                    >${status.count}</a>
                </li>
            </c:if>
        </c:forEach>

        <li <c:if test="${!page.hasNext()}">class="disabled"</c:if>>
            <a href="<%=append.toString()%>start=${page.start+page.count}" aria-label="Next">
                <span>›</span>
            </a>
        </li>
        <li <c:if test="${!page.hasNext()}">class="disabled"</c:if>>
            <a href="<%=append.toString()%>start=${page.getLast()}" aria-label="Next">
                <span>»</span>
            </a>
        </li>
    </ul>
</nav>
