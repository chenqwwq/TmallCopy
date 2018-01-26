/**
 * fore.js收容共用的一些函数
 */
/**
 * 登录检查,已经登录忽略,未登录则调用登录的模态框
 *
 */
function checkLogin() {
    var tempResult = 'false';
    $.ajax({
        type:'get',
        async:false,
        url:"/check_login",
        dataType:"text",
        success:function (result) {
            tempResult = result;
        }
    });
    return tempResult;
}