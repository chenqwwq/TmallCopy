//处理从后端返回的Result Json对象
function DeleteResultHandler(result) {
    if(result.success) {
        alert("删除成功");
        window.location.reload();       //页面刷新代码
        /**
         *  !!!!因为在判断属性期间不能放参数 所以中间用"+"隔开
         *   $("a[cid="+cid+"]").parent().parent().remove();
         *   //通过父元素的父元素删除tr
         *   为了保持页面的统一,改删除为刷新当前野蛮
         */
    }
    else
        alert("删除失败"+result.inf);
}