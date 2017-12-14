<!-- 实现页面的转发 地址栏不变 -->
<%
    request.getRequestDispatcher("/home").forward(request,response);
%>