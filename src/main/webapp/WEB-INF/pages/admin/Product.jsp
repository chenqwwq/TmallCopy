<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-10
  Time: 下午3:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>产品管理</title>
    <%@include file="../public/adminHeader.jsp"%>
    <%@include file="../public/adminNavigator.jsp"%>
</head>
<!--
    产品界面
-->
<body>
    <div class="workingArea">
        <ol class="breadcrumb">
            <li><a href="${basePath}/admin/category">所有分类</a></li>
            <!-- 从跳转的方法中获取一个category属性 -->
            <li><a href="?cid=${category.id}">${category.name}</a></li>
            <li class="active">产品管理</li>
        </ol>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>产品名称</th>
                        <th>产品副标题</th>
                        <th width="53px">原价</th>
                        <th width="80px">优惠价格</th>
                        <th width="80px">库存数量</th>
                        <th width="80px">图片管理</th>
                        <th width="80px">设置属性</th>
                        <th width="42px">编辑</th>
                        <th width="42px">删除</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="p">
                        <tr>
                            <td class="pid">${p.id}</td>
                            <td class="p-name">${p.name}</td>
                            <td class="p-subtitle">${p.subTitle}</td>
                            <td class="p-origin">${p.originalPrice}</td>
                            <td class="p-promote">${p.promotePrice}</td>
                            <td class="p-stock">${p.stock}</td>
                            <td><a href="productImage?pid=${p.id}"><span
                                    class="glyphicon glyphicon-picture"></span></a></td>
                            <td><a href="admin_propertyValue_edit?pid=${p.id}"><span
                                    class="glyphicon glyphicon-th-list"></span></a></td>
                            <td><a id="edit-product" data-toggle="modal" data-target="#edit-product-modal"><span
                                    class="glyphicon glyphicon-edit"></span></a></td>
                            <td><a id="delete-product"><span
                                    class="glyphicon glyphicon-trash"></span></a></td>
                        </tr>                        
                    </c:forEach>
                </tbody>
           </table>
        </div>
    </div>
    <div class="pageDiv">
        <%@include file="../public/adminPage.jsp"%>
    </div>
    <div class="operation-btn-div">
        <!-- 增加商品的模态框的切换按钮 -->
        <button type="button" id="add-product-btn" class="btn btn-default" data-toggle="modal" data-target="#add-product-modal">新增产品</button>
    </div>
    <div class="modal-div">
        <!-- 新增商品的模态框 -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="bg-primary modal-header">
                        <h4 class="modal-title" id="modalLabel">新增产品</h4>
                    </div>
                    <div class="modal-body">
                        <form id="add-product-form">
                            <div class="modal-body-div">
                                <input type="hidden" id="add-product-cid" name="cid" value="${category.id}">
                                <div class="form-group">
                                    <label for="add-product-name">产品名称</label>
                                    <input class="form-control" id="add-product-name" placeholder="产品名称" name="name"/>
                                </div>
                                <div class="form-group">
                                    <label for="add-product-subTitle">产品标题</label>
                                    <input class="form-control" id="add-product-subTitle" placeholder="产品标题" name="subTitle"/>
                                </div>
                                <div class="form-group">
                                    <label for="add-product-originalPrice">原价</label>
                                    <input class="form-control" id="add-product-originalPrice" placeholder="原价" name="originalPrice"/>
                                </div>
                                <div class="form-group">
                                    <label for="add-product-promotePrice">优惠价</label>
                                    <input class="form-control" id="add-product-promotePrice" placeholder="优惠价" name="promotePrice"/>
                                </div>
                                <div class="form-group">
                                    <label for="add-product-stock">库存</label>
                                    <input class="form-control" id="add-product-stock" placeholder="库存" name="stock"/>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="modal-footer-div">
                            <button type="button" class="btn btn-default modal-footer-btn" data-dismiss="modal">关闭</button>
                            <button id="add-product-modal-btn" class="btn-primary btn modal-footer-btn">提交</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="edit-product-modal" tabindex="-1" role="dialog" aria-labelledby="edit-product-modal-label">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="bg-primary modal-header">
                        <h4 class="modal-title" id="edit-product-modal-label">修改产品</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body-div">
                            <form id="edit-product-form">
                                <input type="hidden" id="edit-product-id" name="id"/>
                                <div class="form-group">
                                    <label for="edit-product-name">产品名称</label>
                                    <input class="form-control" id="edit-product-name" placeholder="产品名称" name="name"/>
                                </div>
                                <div class="form-group">
                                    <label for="edit-product-subTitle">产品标题</label>
                                    <input class="form-control" id="edit-product-subTitle" placeholder="产品标题" name="subTitle"/>
                                </div>
                                <div class="form-group">
                                    <label for="edit-product-originalPrice">原价</label>
                                    <input class="form-control" id="edit-product-originalPrice" placeholder="原价" name="originalPrice"/>
                                </div>
                                <div class="form-group">
                                    <label for="edit-product-promotePrice">优惠价</label>
                                    <input class="form-control" id="edit-product-promotePrice" placeholder="优惠价" name="promotePrice"/>
                                </div>
                                <div class="form-group">
                                    <label for="edit-product-stock">库存</label>
                                    <input class="form-control" id="edit-product-stock" placeholder="库存" name="stock"/>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="modal-footer-div">
                            <button type="button" class="btn btn-default modal-footer-btn" data-dismiss="modal">关闭</button>
                            <button type="button" id="edit-product-modal-btn" class="btn btn-primary modal-footer-btn">提交</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="application/javascript">
    /**
     *  提交更新form
     */

    $("button#edit-product-modal-btn").click(function () {
        //构建form表单信息对象
        var formData = new FormData(document.getElementById("edit-product-form"));
        formData.append("_method",'put');
        //发送ajax异步put请求
        $.ajax({
            type:'post',
            data:formData,
            processData: false,
            contentType: false,
            success:function (result) {
                ResultHandler(result);
            },
            error:function () {
                console.log("系统错误");
            }
        });


    });
    /**
     *  点击编辑按钮的触发事件
     */
    $("a#edit-product").click(function () {
        $("input#edit-product-id").val(getVal($(this),".pid"));
        $("input#edit-product-name").val(getVal($(this),".p-name"));
        $("input#edit-product-subTitle").val(getVal($(this),".p-subtitle"));
        $("input#edit-product-originalPrice").val(getVal($(this),".p-origin"));
        $("input#edit-product-promotePrice").val(getVal($(this),".p-promote"));
        $("input#edit-product-stock").val(getVal($(this),".p-stock"));
    });

    function getVal(element,class_){
        return element.parents().siblings(class_).text();
    }

    /**
     *   增加操作
     * 直接使用ajax的post请求传递参数到后台
     */

    $("button#add-product-modal-btn").click(function () {
        //获取整个form表单的数据
        var formData = new FormData(document.getElementById("add-product-form"));
        //发送post请求
        $.ajax(
            {
                type:"post",
                data:formData,
                processData:false,
                contentType:false,
                success:function (result) {
                    ResultHandler(result);
                },
                error:function () {
                    console.log("系统错误")
                }
            }
        );
    });
    /**
     *     删除操作
     * 使用post包装的delete请求发送到后端
     */
    $("a#delete-product").click(function () {
        //获取相应的productID
        var pid = $(this).parents().siblings(".pid").text();
        //以delete发送ajax请求
        $.ajax({
            type:"post",
            data:{
                id:pid,
                _method:'delete'
            },
            success:function (result) {
                ResultHandler(result);
            },
            error:function () {
                console.log("系统错误");
            }
        });
    });
</script>
</html>
