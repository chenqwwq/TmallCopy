package chen.interceptor;
/**
 * 将加载分类信息用于搜索栏下方显示的步骤放在本Interceptor
 */

import chen.entity.Category;
import chen.service.CategoryService;
import chen.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class CategoryInfInterceptor  extends HandlerInterceptorAdapter {

    private final CategoryService categoryService;
    private final ProductService productService;

    @Autowired
    public CategoryInfInterceptor(CategoryService categoryService, ProductService productService) {
        this.categoryService = categoryService;
        this.productService = productService;
    }

    /**
     * 该方法在处理器执行链之前执行
     * 用该方法向部分页面注入category信息
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //Test
//        System.out.println("preHandle method of CategoryInfInterceptor is running from "+request.getRequestURI());
        //获取全部分类信息
        List<Category> categories = categoryService.list();
        //填充Product
        productService.fill(categories);
        //product分组操作
        productService.fillByGroup(categories);
        request.getSession().setAttribute("categories",categories);
        //设置属性
        return true;
    }
}
