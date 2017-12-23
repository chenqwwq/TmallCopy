package chen.controller;

/**
 * 该类仅仅用来跳转到指定的页面
 */

import chen.entity.Category;
import chen.service.CategoryService;
import chen.service.OrderService;
import chen.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class PageController {
    private final CategoryService categoryService;
    private final ProductService productService;
    private final OrderService orderService;

    public PageController(CategoryService categoryService, ProductService productService, OrderService orderService) {
        this.categoryService = categoryService;
        this.productService = productService;
        this.orderService = orderService;
    }

    /**
     * 简单的页面跳转逻辑
     * @return
     */

    @ModelAttribute("categories")
    private List<Category> getCategories(){
        List<Category> categories = categoryService.list();
        //填充Product
        productService.fill(categories);
        //将Product分组
        productService.fillByGroup(categories);
        return categories;
    }

    //主页
    @RequestMapping("/home")
    private String home(){
        return "fore/Home";
    }

    //注册页面
    @RequestMapping("/register")
    private String register(){
        return "fore/Register";
    }

    //登录界面
    @RequestMapping("/login")
    private String login(){
        return "fore/Login";
    }

    //功能测试页面
    @RequestMapping("/myTest")
    private String Test(Model model){
        return "fore/Test";
    }
}
