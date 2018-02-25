<!-- 实现页面的转发 地址栏不变 -->
<%
    //Server jump
//    request.getRequestDispatcher("/home").forward(request,response);
    //Client jump
    response.sendRedirect("/home");
%>
