package chen.controller;

import chen.entity.Category;
import chen.service.CategoryService;
import chen.service.ProductService;
import chen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * 前端页面的Controller
 *      也就是前端页面的路径管理
 */
@Controller
public class ForeController {

    private final UserService userService;
    private final CategoryService categoryService;
    private final ProductService productService;

    @Autowired
    public ForeController(UserService userService, CategoryService categoryService, ProductService productService) {
        this.userService = userService;
        this.categoryService = categoryService;
        this.productService = productService;
    }


    /*Title*
     * 首页的定位方法
     * @param model
     */
    @RequestMapping("/home")
    private String home(Model model){
        List<Category> categories = categoryService.list();
        //填充Product
        productService.fill(categories);
        //将Product分组
        productService.fillByGroup(categories);
        model.addAttribute("categories",categories);
        return "fore/Home";
    }
    @RequestMapping("/register")
    private String register(Model model){
        List<Category> categories = categoryService.list();
        model.addAttribute("categories",categories);
        return "fore/Register";
    }
}
