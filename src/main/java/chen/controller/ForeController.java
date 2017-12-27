package chen.controller;
/**
 * 该类在设计中用来完全前端页面的各种任务
 *      1.登录
 *      2.退出
 *      3.注册
 *      4.用户名验证
 *      5.商品详情查看
 */

import chen.dto.Result;
import chen.entity.*;
import chen.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
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
    private final OrderService orderService;
    private final ProductImageService productImageService;
    private final PropertyValueService propertyValueService;
    private final ReviewService reviewService;

    @Autowired
    public ForeController(UserService userService, CategoryService categoryService, ProductService productService, OrderService orderService, ProductImageService productImageService, PropertyValueService propertyValueService, ReviewService reviewService) {
        this.userService = userService;
        this.categoryService = categoryService;
        this.productService = productService;
        this.orderService = orderService;
        this.productImageService = productImageService;
        this.propertyValueService = propertyValueService;
        this.reviewService = reviewService;
    }

    //为需要类别数据的前端页面统一分配数据
    //此处使用该注解可能有些勉强 仅仅作为练习使用
    /**
     * 在Fore的所有带有RequestMapping注解的方法执行前都会执行该方法
     * 为所有的Model添加key=categories的数据
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

    /**
     * 退出的业务逻辑
     * @param session
     * @param model
     * @return
     */
    @RequestMapping("/logout")
    private String LogOut(HttpSession session,Model model){
        //因为退出操作之后并不需要商品数据 Model中的categories便为多余 浪费资源
        model.addAttribute("categories",null);
        //从会话属性中删除user对象
        session.removeAttribute("user");
        //跳转回到登录界面
        return "fore/Login";
    }


    /**
     * 登录的业务逻辑
     * @param name
     * @param password
     * @param session
     * @param model
     * @return
     */
    @PostMapping("/login")
    private String VerifyLogin(String name, String password, HttpSession session,Model model){
        //获取User
        User user = userService.verify(name,password);
        if(user != null){
            orderService.loadWaitPayCount(user);
            session.setAttribute("user",user);
            return "redirect:/home";
        }else{
            model.addAttribute("msg","账号密码错误");
            return "redirect:/login";
        }
    }

    @PostMapping("/login_ajax")
    @ResponseBody
    private Result loginAjax(String name,String password,HttpSession httpSession){
        //尝试获取User
        User user = userService.verify(name,password);
        if(user != null){
            orderService.loadWaitPayCount(user);
            httpSession.setAttribute("user",user);
            return new Result();
        }else{
            return new Result("账号密码错误");
        }
    }

    /**
     * 检查用户名是否存在的业务逻辑
     * 因为前端的用户注册直接调用了
     * @param name
     * @return
     */
    @PostMapping("/verify_register")
    @ResponseBody
    private Result VerifyUsername(String name){
        /**
         * true表示用户名已经存在
         * false表示尚未注册
         */
        return userService.verify(name)?new Result("用户名已经被注册!请重试"):new Result();
    }

    @GetMapping("/check_login")
    @ResponseBody
    private int CheckLogin(HttpSession httpSession){
        return httpSession.getAttribute("user") != null?1:0;
    }

    @PostMapping("/register")
    @ResponseBody
    private Result Register(User user,Model model){
        userService.add(user);
        return new Result();
    }

    /**
     * Product页面
     */
    @RequestMapping("/product")
    private String product(int pid,Model model){
        //获取相应product实例对象
        Product product = productService.get(pid);
        productService.setSaleAndReviewNumber(product);
        //加载各类图片到product的属性
        productImageService.LoadImage(product,ProductImageService.type_single);
        productImageService.LoadImage(product,ProductImageService.type_detail);
        //获取所有商品属性
        List<PropertyValue> propertyValues = propertyValueService.list(pid);
        //获取所有评论
        List<Review> reviews = reviewService.listByPid(pid);
        //计算销量和评论总量
        //此处感觉和上一步有点重合，可以直接计算上一步大小并赋值
        productService.setSaleAndReviewNumber(product);
        //Model属性添加
        model.addAttribute("product",product);
        model.addAttribute("propertyValues",propertyValues);
        model.addAttribute("reviews",reviews);
        //页面跳转
        return "fore/Product";
    }

}
