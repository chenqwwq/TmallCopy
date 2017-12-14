//猫耳朵效果的script
$(function () {
    $("div.rightMenu span").mouseleave(function () {
        $("img.catHead").hide();
    });
    $("div.rightMenu span").mouseenter(function () {
        //获取离左边和最上面距离 以及 该元素的宽
        var left = $(this).position().left;
        var top = $(this).position().top;
        var width = $(this).css("width");
        //计算最终的left
        var destLeft = parseInt(left) + parseInt(width)/2;
        //设定属性
        $("img#catHead").css("left",destLeft);
        $("img#catHead").css("top",top+150);
        $("img#catHead").fadeIn(500);
    });
});

