<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 17-11-12
  Time: 下午4:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<%@include file="../public/admin/adminHeader.jsp"%>
<%@include file="../public/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>产品图片管理</title>
    <style type="text/css">
        div.productImage-div{
            vertical-align: top;
            display: inline-block;
            width: 100%;
            height: 500px;
            overflow: auto;
        }
        td.pi-id-td{
            width: 20%;
        }
        td.pi-delete-td{
            width: 10%;
        }
        tr.pi-tr{
            height: 65px;
        }
        ul#image-tab{
            padding-left: 100px;
        }
        .canClick{
            cursor: pointer;
        }
        .myHidden{
            display: none;
        }
        .center{
            margin: 0 auto;
        }
        .add-width{
            width: 30%;
        }
    </style>
    <script>

        function changeActive(element) {
            //选取同时具有li-tab和active两个属性的li
            $("li.li-tab.active").removeClass('active');
            //从该元素的读元素开始向上遍历 寻找li
            //closest表示从该元素开始向上遍历，找到第一个相符合的元素
            element.closest('li.li-tab').addClass('active');
        }

        function changeDiv(element) {
            //找到没有myHidden的div元素 该元素就是显示的div
            $("div.productImage-tab-div:not('.myHidden')").addClass('myHidden');
            //构造需要显现的div
            var divId = 'div#div-'+element.attr("id");
            $(divId).removeClass('myHidden');
        }

        function tabSwitch(element) {
            //转换active状态
            changeActive(element);
            //转换div的现实
            changeDiv(element)
        }

        $(
            function () {
                $("a.productImg-tab-a").each(function () {
                    $(this).click(function () {
                        tabSwitch($(this))
                    });
                });

            }
        );
    </script>
</head>
<body>
    <div class="workingArea">
        <!-- 面包屑导航 -->
        <ol class="breadcrumb">
            <li><a href="${basePath}/admin/category">所有分类</a></li>
            <li><a href="${basePath}/admin/product?cid=${product.category.id}">${product.category.name}</a></li>
            <li><a href="${basePath}/admin/productImage?pid=${product.id}">${product.name}</a></li>
            <li class="active ">产品图片管理</li>
        </ol>
        <ul id="image-tab" class="nav nav-tabs">
            <!--
                因为最外层的三个li是在点击的时候需要转化active的 所以统一标记为li-tab,方便选取
                里层a的id和div的id一一对应方便显示

                有显示和隐藏需求的div统一有一个productImage-tab-div 方便于选取转化
            -->
            <li role="presentation" class="active li-tab" ><a id="img-single" class="productImg-tab-a" href="#">单个图片</a></li>
            <li role="presentation" class="li-tab"><a id="img-detail" class="productImg-tab-a" href="#">详情图片</a></li>
            <li role="presentation" class="li-tab">
                <a id="drop1" href="#" data-toggle="dropdown" aria-expanded="false">
                    上传图片
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu" aria-labelledby="drop1">
                    <li>
                        <a id="add-single" class="productImg-tab-a" href="#">单个图片</a>
                    </li>
                    <li>
                        <a id="add-detail" class="productImg-tab-a"  href="#">详细图片</a>
                    </li>
                </ul>
            </li>
        </ul>
        <!--
            productImage-div
                是productImage页面主要的内容模块
            myHidden
                自定义的隐藏类
            //重新构造两个添加界面的ui 可以考虑二合一
        -->
        <div class="productImage-div">
            <div id="div-img-single" class="productImage-tab-div" >
                <table class="productImage-show-table table table-striped table-bordered table-hover table-condensed">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>缩略图</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${productImage_single}" var="ps">
                        <tr class="pi-tr">
                            <td class="pi-id-td">${ps.id}</td>
                            <td class="pi-img-td">
                                <a title="点击查看原图" href="/img/productSingle/${ps.id}.jpg">
                                    <img height="50px" src="/img/productSingle/${ps.id}.jpg">
                                </a>
                            </td>
                            <td class="pi-delete-td">
                                <a id="delete-productImage-single-btn" class="productImage-delete">
                                    <span class="glyphicon glyphicon-trash"></span>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="div-img-detail" class="productImage-tab-div myHidden">
                <table class="productImage-show-table table table-striped table-bordered table-hover table-condensed">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>缩略图</th>
                        <th>删除</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!--
                        pi-tr pi-id-tr pi-img-tr pi-delete-tr
                            是为了规范图片显示table的外观
                     -->
                    <c:forEach items="${productImage_detail}" var="pd">
                        <tr class="pi-tr">
                            <td class="pi-id-td">
                                    ${pd.id}
                            </td>
                            <td class="pi-img-td">
                                <a title="点击查看原图" href="/img/productDetail/${pd.id}.jpg">
                                    <img height="50px" src="/img/productDetail/${pd.id}.jpg">
                                </a>
                            </td>
                            <td class="pi-delete-td">
                                <a id="delete-productImage-detail-btn" class="productImage-delete">
                                    <span class="glyphicon glyphicon-trash"></span>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <script type="application/javascript">
                $(function () {
                    $("a.productImage-delete").each(function () {
                        $(this).click(function () {
                            //获取需要删除的productImage的id
                            var local_id = $(this).parent().siblings('.pi-id-td').text();
                            //发送delete请求
                            $.ajax({
                                type:'post',
                                data:{
                                    id : local_id,
                                    _method:'delete'
                                },
                                success:function (result) {
                                    ResultHandler(result);
                                },
                                error:function () {
                                    console.log("系统错误")
                                }
                            });
                        });
                    });
                });
            </script>
            <div id="div-add-single" class="productImage-tab-div myHidden">
                <form method="post" enctype="multipart/form-data">
                    <table class="add-width center table table-striped table-bordered table-hover table-condensed" style="text-align: center">
                        <tr>
                            <td class="bg-primary">添加单个图片</td>
                        </tr>
                        <tr>
                            <td class="bg-danger">请选择本地图片 尺寸400X400 为佳</td>
                        </tr>
                        <tr>
                            <td align="center">
                                <input type="file" name="image" />
                                <input type="hidden" name="type" value="type_single">
                                <input type="hidden" name="pid" value="${product.id}">
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <button class="btn btn-success">提 交</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div id="div-add-detail" class="productImage-tab-div myHidden">
                <form method="post" enctype="multipart/form-data">
                    <table class="add-width center table table-striped table-bordered table-hover table-condensed" style="text-align: center">
                        <tr>
                            <td class="bg-primary">添加详细图片</td>
                        </tr>
                        <tr>
                            <td class="bg-danger">请选择本地图片 尺寸400X400 为佳</td>
                        </tr>
                        <tr>
                            <td align="center">
                                <input type="file" name="image" />
                                <input type="hidden" name="type" value="type_detail">
                                <input type="hidden" name="pid" value="${product.id}">
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <button class="btn btn-success">提 交</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
