<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-7
  Time: 上午8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../public/adminHeader.jsp"%>
<html>
<head>
    <title>测试界面</title>
<body>
    <%--<form action="/upload" method="post" enctype="multipart/form-data">--%>
        <%--<input type="hidden" name="_method" value="put"/>--%>
        <%--<input type="file" name="file"/>--%>
        <%--<input type="submit" value="submit">--%>
    <%--</form>--%>
    <%--<form id="formData" method="post" enctype="multipart/form-data">--%>
        <%--<input type="file" name="file">--%>
    <%--</form>--%>
    <%--<button type="button" id="submit-btn" >submit</button>--%>
    <%--<button type="button" id="btn">提交</button>--%>
    <%--<script>--%>
        <%--$("button#submit-btn").click(function () {--%>
            <%--alert("进入ajax方法");--%>
            <%--var formData = new FormData(document.getElementById("formData"));--%>
            <%--formData.append("_method",'put');--%>
            <%--$.ajax({--%>
                <%--url:"upload",--%>
                <%--type:'post',--%>
                <%--data:formData,--%>
                <%--processData: false,--%>
                <%--contentType: false,--%>
                <%--success:function () {--%>
                    <%--alert("上传成功")--%>
                <%--},--%>
                <%--error:function () {--%>
                    <%--alert("上传失败")--%>
                <%--}--%>
            <%--});--%>
        <%--});--%>
    <%--</script>--%>

    <!-- 以上为put形式以ajax和form上传文件的测试 -->

    <%
        StringBuilder append = new StringBuilder("?");
        if(request.getQueryString() != null){
            String[] s = request.getQueryString().split("&");
            for (int i = 0;i < s.length;i++){
                if(s[i].startsWith("start")){
                    s[i] = "";       //将start参数重置
                }
            }
            for (String t : s){
                if(!Objects.equals(t, ""))
                    append.append(t).append("&");       //重构基础参数
            }
        }
    %>

    <%= append%>
</body>
</html>
