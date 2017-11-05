<!-- 模仿天猫整站ssm 教程 为how2j.cn 版权所有-->
<!-- 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关-->
<!-- 供购买者学习，请勿私自传播，否则自行承担相关法律责任-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="s" uri="/struts-tags"%>



<%
	pageContext.setAttribute("pageName","Stage");
%>


<html>

<%@ include file="include/header.jsp"%>

<script>
    $(function() {

        $("#internalSearchKeyword").keyup(function(){
            var keyword = $(this).val();

            var data = "internalSearchKeyword="+keyword;

            $.ajax({
                type: "POST",
                url: "managesearchResultKnowledge",
                data: data,
                success:
                    function (data, textStatus) {
                        $("#result").html(data);
                    }
            });

        });


    });
</script>



<body>
<h1>全文查询</h1>

<div align="center">
	<!--		 		<form action="managesearchResultKnowledge" method="post">-->
	<input id="internalSearchKeyword" type="text" name="internalSearchKeyword"/>
	<!--		 		</form>-->


</div>

<br/>
<br/>
<br/>

<div align="center" id="result">

</div>
</body>
</html>
