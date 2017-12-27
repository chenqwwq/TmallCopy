$(function () {
    var big_img = $("div.Img img.product-big-img");
    /**
     * 预览图切换的鼠标触发事件
     */
    $("div.product-small-img img").mouseenter(function () {
        // var name = $(this).attr("src").split("/")[2].split(".")[0];
        //获取原来的图片地址
        var oldSrc = $(this).attr("src");
        //替换src中的二级目录 构造新的图片地址
        var newSrc = oldSrc.replace("productSingle_small","productSingle");
        //替换大图的地址
        big_img.attr("src",newSrc);
    });
    /**
     * 添加增加/减少购买数量的箭头按钮的点击事件
     */
    var buyNumber_input = $("input.buy-number-input");
    $("span.arrow a.increase-number").click(function () {
        buyNumber_input.val(parseInt(buyNumber_input.val()) + 1);
    });
    $("span.arrow a.decrease-number").click(function () {
        buyNumber_input.val(parseInt(buyNumber_input.val()) - 1);
    });

    /**
     * 商品详情和商品评价的切换函数
     */
    $("div.product-title-div a").click(function () {
        //判断该元素是否具有selected属性
        if($(this).hasClass("selected"))
            return;
        //获取原selected的元素
        var selectA =$("div.product-title-div a.selected");
        //删除原元素的selected属性
        selectA.removeClass("selected");
        //构建需要显示的divId
        $("div."+selectA.attr("id")+"-div").hide();
        //为该元素加上selected属性
        $(this).addClass("selected");
        //显示对应的div
        $("div."+$(this).attr("id")+"-div").show();
    });

    /**
     * 登录检查,
     *     已经登录忽略,
     *     未登录则调用登录的模态框
     */
    // function checkLogin(){
    //     $.get({
    //         url : "/check_login",
    //         success:function (result) {
    //             /**
    //              * 是否有登陆的不同处理结果
    //              */
    //             if(result)
    //                 return;
    //             else{
    //                 $("div#login-modal").modal("show");
    //             }
    //         }
    //     })
    // }
});