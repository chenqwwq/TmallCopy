<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-1
  Time: 下午10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<%@include file="../public/adminHeader.jsp"%>
<%@include file="../public/adminNavigator.jsp"%>
<html>
<head>
    <title>分类管理</title>

</head>
<body>
<div class="workingArea">
    <span class="label label-info" >分类管理</span>
    <br>
    <br>
    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>图片</th>
                <th>分类名称</th>
                <th>属性管理</th>
                <th>产品管理</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${categories}" var="c">
                <tr>
                    <%--<a href="javascript:if(confirm('确实要删除吗?'))location='jb51.php?id='">删除</a>--%>
                    <td>${c.id}</td>
                    <td><img height="40px" src="/img/category/${c.id}.jpg"></td>
                    <td>${c.name}</td>
                    <td><a href="property/${c.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                    <td><a href="admin_product_list?cid=${c.id}"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>
                    <td><a href="admin_category_edit?id=${c.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a id="delete_category" dataId=${c.id}><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="pageDiv">
        <%@include file="../public/adminPage.jsp"%>
        <button id="add_category_btn" class="btn btn-default">增加分类</button>
        <div class="panel panel-warning addDiv">
            <div class="panel-heading">新增分类</div>
            <div class="panel-body">
                <!-- 文件上传的post,因为ajax不会 所以直接使用form表单上传 -->
                <form method="post" id="addForm" action="" enctype="multipart/form-data">
                    <table class="addTable">
                        <tr>
                            <td>分类名称</td>
                            <td><input  id="name" name="name" class="form-control"></td>
                        </tr>
                        <tr>
                            <td>分类图片</td>
                            <td>
                                <input id="categoryPic" accept="image/*" type="file" name="image" />
                            </td>
                        </tr>
                        <tr class="submitTR">
                            <td colspan="2" align="center">
                                <button class="btn btn-success">提 交</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
    </div>
</div>
</div>
</body>
<script type="text/javascript">

    /*
     *   此处不知道是什么bug,后台的DeleteMapper完全接收不到ajax的参数
     *   使用网上的方法后成功,在web.xml中添加两个filter,在使用POST请求承载_method参数
     */
    $("a#delete_category").click(function () {
        $.ajax({
            //因为使用操作符表示 所以使用统一的url
            type:"POST",
            data: {
                id:$(this).attr('dataId'),
                _method:'DELETE'
            },
            success:function (result) {
                DeleteResultHandler(result);
            },
            error:function () {
                alert("系统错误")
            }
        });
    });
</script>
</html>
