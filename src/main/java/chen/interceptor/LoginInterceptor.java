package chen.interceptor;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

/**
 * 登录拦截器
 * 继承HandlerInterceptorAdapter实现其中preHandler方法,
 */
public class LoginInterceptor extends HandlerInterceptorAdapter{
    public LoginInterceptor() {
        super();
        System.out.println("The LoginInterceptor is initializing");
    }

    /**
     * 在业务处理器执行之前调用
     * About Session:
     *      1.只有在访问Jsp或者Servlet的时候才会产生Session,访问纯Html或者Image等静态资源的时候不会产生Session,
     * 可以使用request.getSession(true),强制生成Session
     *      2.因为Session一般存储在服务器的内存里,所以如果当Session过于繁琐的时候会导致存取速度的降低,严重的会发生内存
     * 溢出.
     *      3.Session是保存在服务器端的信息存储对象,Cookie是保存在客户端的信息存储对象
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //1.Get the HttpSession object.
        HttpSession session = request.getSession();
        //2.Get the context path as a String object, this is a relative path.
        String contextPath = session.getServletContext().getContextPath();
        //3.Get the request uri.
        String uri = request.getRequestURI();
        //4.Remove the redundant part.
        uri = StringUtils.remove(uri,contextPath);
        //5.This list is all of the path that does not need to login.
        List<String> noLoginList = Arrays.asList("/login","/home");                  //singletonList : This method is used to generate a read-only list.
        //Judgement step 1 : uri.
        if(!noLoginList.contains(uri)){
            //Judgement step 2 : Whether or not to login.
            if(null == session.getAttribute("user")){
                //Redirecting to login page.
                response.sendRedirect("/login");
                return false;
            }
        }
        return true;
    }
}
