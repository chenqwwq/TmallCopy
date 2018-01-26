package chen.controller;

/**
 * 该类仅仅用来跳转到指定的页面
 */

import chen.entity.Category;
import chen.entity.OrderItem;
import chen.entity.Product;
import chen.entity.User;
import chen.service.CategoryService;
import chen.service.OrderItemService;
import chen.service.OrderService;
import chen.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.List;

@Controller
public class PageController {
    private final CategoryService categoryService;
    private final ProductService productService;
    private final OrderService orderService;
    private final OrderItemService orderItemService;

    public PageController(CategoryService categoryService, ProductService productService, OrderService orderService, OrderItemService orderItemService) {
        this.categoryService = categoryService;
        this.productService = productService;
        this.orderService = orderService;
        this.orderItemService = orderItemService;
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


    @GetMapping("/category")
    private String Category(int cid,String sort,Model model){
        //Get the corresponding Category object
        Category category = categoryService.get(cid);
        //Loading the Product object
        productService.fill(category);
        //Loading the corresponding attributes
        productService.setSaleAndReviewNumber(category.getProducts());

        //The main local code of the sort
        if(null != sort) {
            switch (sort) {
                case "all":
                    category.getProducts().sort((p1, p2) -> p2.getReviewCount() * p2.getSaleCount() - p1.getReviewCount() * p1.getSaleCount());
                    break;
                case "review":
                    category.getProducts().sort((o1, o2) -> o2.getReviewCount() - o1.getReviewCount());
                    break;
                case "date":
                    category.getProducts().sort(Comparator.comparing(Product::getCreateDate));
                    break;
                case "saleCount":
                    category.getProducts().sort((o1, o2) -> o2.getSaleCount() - o1.getSaleCount());
                    break;
                case "priceAsc":
                    category.getProducts().sort((o1, o2) -> (int) (o1.getPromotePrice() - o2.getPromotePrice()));
                    break;
                case "priceDes":
                    category.getProducts().sort((o1, o2) -> (int) (o2.getPromotePrice() - o1.getPromotePrice()));
                    break;
            }
        }
        //Set up the page attributes
        model.addAttribute("category",category);
        return "fore/ProductsByCategory";
    }

    @RequestMapping("/cart")
    private String Cart(Model model, HttpSession httpSession){
        //获取User
        User user = (User)httpSession.getAttribute("user");
        //是否登录检测
        if(user != null) {
            //获取需要的数据实例
            List<OrderItem> orderItems = orderItemService.listByUser(((User) httpSession.getAttribute("user")).getId());
            //设置页面属性
            model.addAttribute("orderItems", orderItems);
            //制定目标界面
            return "fore/Cart";
        }else
            return "redirect:login";
    }


    //功能测试页面
    @RequestMapping("/myTest")
    private String Test(Model model){
        return "fore/Test";
    }

}
