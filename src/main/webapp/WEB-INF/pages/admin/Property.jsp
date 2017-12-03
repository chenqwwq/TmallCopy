<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-4
  Time: 下午9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>属性管理</title>
    <%@include file="../public/admin/adminHeader.jsp"%>
    <%@include file="../public/admin/adminNavigator.jsp"%>
</head>
<body>
    <div class="workingArea">
        <!-- 面包屑导航 -->
        <ol class="breadcrumb">
            <li><a href="/admin/category">所有分类</a></li>    <!-- 跳到分类页面 -->
            <li><a href="?cid=${category.id}">${category.name}</a></li>    <!-- 本页面 -->
            <li class="active">属性管理</li>
        </ol>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover  table-condensed">
                <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>属性名称</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${properties}" var="p">
                    <tr>
                        <td class="pid">${p.id}</td>
                        <td class="pname">${p.name}</td>
                        <td>
                            <a id="edit_property" data-toggle="modal" data-target="#editPropertyModal">
                                <span class="glyphicon glyphicon-edit"></span>
                            </a>
                        </td>
                        <td>
                            <a id="delete_property">
                                <span class="glyphicon glyphicon-trash"></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="pageDiv">
            <%@include file="../public/admin/adminPage.jsp"%>
        </div>
        <div class="operation-btn-div">
            <button type="button" id="add-property" class="btn btn-default" data-toggle="modal" data-target="#addPropertyModal">新增属性</button>
            <!-- 新增属性的模态框 -->
            <div class="modal fade" id="addPropertyModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="bg-primary modal-header">
                            <h4 class="modal-title" id="ModalLabel">新增属性</h4>
                        </div>
                        <div class="modal-body">
                            <div class="modal-body-div">
                                <div class="modal-body-input-div">
                                    <label for="addPropertyName">属性名称:</label>
                                    <input id="addPropertyName"/>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="modal-footer-div">
                                <button type="button" class="btn btn-default modal-footer-btn" data-dismiss="modal">关闭</button>
                                <button id="modal-add-property" class="btn btn-primary modal-footer-btn">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="editPropertyModal" tabindex="-1" role="dialog" aria-labelledby="editPropertyModal-title">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="bg-primary modal-header">
                            <h4 class="modal-title" id="editPropertyModal-title">修改属性</h4>
                        </div>
                        <div class="modal-body">
                            <div class="modal-body-div">
                                <div class="modal-body-input-div">
                                    <input type="hidden" id="editPropertyId">
                                </div>
                                <div class="modal-body-input-div">
                                    <label for="editPropertyName">属性名称:</label>
                                    <input id="editPropertyName" placeholder="属性名称">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="modal-footer-div">
                                <button class="btn btn-default modal-footer-btn" data-dismiss="modal">关闭</button>
                                <button class="btn btn-primary modal-footer-btn" id="modal-edit-property">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">

    /**
     *  在弹出修改属性的模态框之前,将id和name分别注入
     *  直接将该事件绑定在修改按钮
     */
    $("a#edit_property").click(function () {
        $("input#editPropertyId").val(getIdForUD($(this)));
        $("input#editPropertyName").val($(this).parents().siblings(".pname").text());
    });

    /**
     *  修改属性的点击事件
     */
    $("button#modal-edit-property").click(function () {
        //获取属性id
        var pid = $("input#editPropertyId").val();

        //获取属性名称
        var pname = $("input#editPropertyName").val();

        $.ajax({
            type:"post",
            data:{
                id:pid,
                name:pname,
                _method:"put"
            },
            success:function (result) {
                ResultHandler(result);
            },
            error:function () {
                alert("系统错误");
                console.log("系统错误");
            }
        });
    });

    /**
     * 新增属性的点击事件
     */
    $("button#modal-add-property").click(function () {
        //获取属性name
        var pname = $("input#addPropertyName").val();
        var cid = ${category.id};
        $.ajax({
            type:"post",
            data:{
                name:pname,
                cid:cid
            },
            success:function (result) {
                console.log("增加成功");
                ResultHandler(result);
            },
            error:function () {
                console.log("系统错误");
            }
        });
    });

    /**
     * 获取更新或者删除所需要的分类Id
     * @param element
     */
    function getIdForUD(element) {
        return element.parents().siblings(".pid").text();
    }

    /**
     * 删除的点击事件
     */
    $("a#delete_property").click(function () {
        $.ajax({
            type:"POST",
            data:{
                pid:getIdForUD($(this)),
                _method:'DELETE'
            },
            success:function (result) {
                ResultHandler(result);
            },
            error:function () {
                alert("系统错误")
            }
        });
    });
</script>
</html>
