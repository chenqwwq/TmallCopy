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
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
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
    private final OrderItemService orderItemService;

    @Autowired
    public ForeController(UserService userService, UserService userService1, CategoryService categoryService, ProductService productService, OrderService orderService, ProductImageService productImageService, PropertyValueService propertyValueService, ReviewService reviewService, OrderItemService orderItemService) {
        this.userService = userService1;
        this.categoryService = categoryService;
        this.productService = productService;
        this.orderService = orderService;
        this.productImageService = productImageService;
        this.propertyValueService = propertyValueService;
        this.reviewService = reviewService;
        this.orderItemService = orderItemService;
    }

    //为需要类别数据的前端页面统一分配数据
    //此处使用该注解可能有些勉强 仅仅作为练习使用
    //使用Interceptor代替
    /**
     * 在Fore的所有带有RequestMapping注解的方法执行前都会执行该方法
     * 为所有的Model添加key=categories的数据
     * @return
     */
//    @ModelAttribute("categories")
//    private List<Category> getCategories(){
//        List<Category> categories = categoryService.list();
//        填充Product
//        productService.fill(categories);
//        将Product分组
//        productService.fillByGroup(categories);
//        return categories;
//    }

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

    //支付页面
    @RequestMapping("/alipay")
    private String alipay(){
        return "fore/Alipay";
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
        return "redirect:/login";

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
            //加载等待付款的数目
            orderService.loadWaitPayCount(user);
            //设置页面属性
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
    private boolean CheckLogin(HttpSession httpSession){
        return httpSession.getAttribute("user") != null;
    }

    @PostMapping("/register")
    @ResponseBody
    private Result Register(User user){
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

    @GetMapping("/search")
    private String Search(String keyword,Model model){
        //分页设置
        PageHelper.offsetPage(0,20);
        //获取实体对象
        List<Product> products = productService.search(keyword);
        //加载其他属性
        productService.setSaleAndReviewNumber(products);
        //设置页面属性
        model.addAttribute("products",products);
        return "fore/SearchResult";
    }

    @GetMapping("/buy")
    private String buy(int pid,int num,HttpSession httpSession){
        //根据pid获取相应的product
        Product product = productService.get(pid);
        //获取存储在Session中的User对象
        //检查Session中有无User的步骤在页面
        User user = (User) httpSession.getAttribute("user");
        //根据uid获取该用户所有的订单项
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        int orderItemId = -1;
        /**
         * 根据订单项存不存在的两种情况分别处理
         */
        //1、订单项已经存在
        for(OrderItem orderItem : orderItems){
            //根据pid是否一样判断订单项是否一致
            if(orderItem.getPid() ==  pid){
                //订单项已经存在
                //直接增加num
                orderItem.setNumber(orderItem.getNumber()+num);
                //更新orderItem
                orderItemService.update(orderItem);
                //获取orderItemID
                orderItemId = orderItem.getId();
                //跳出for循环
                break;
            }
        }
        //orderItemId等于-1 则代表订单项不存在
        if(orderItemId == -1){
            //新建OrderItem对象
            OrderItem orderItem = new OrderItem();
            //添加OrderItem属性
            // 因为是保存到数据库的,所以Product相关只装载pid
            orderItem.setPid(pid);
            orderItem.setUid(user.getId());
            orderItem.setNumber(num);
            //新增OrderItem
            orderItemService.add(orderItem);
            //获取new OrderItem的id
            orderItemId = orderItem.getId();
        }
        //返回到结算页面
        return "redirect:settlement?orderItemId="+orderItemId;
    }

    @RequestMapping("/settlement")
    /**
     * 此处之所以是要用int[] OrderItems是为了统一 直接购买 和 从购物车选定结算
     */
    private String settlement(Model model,int[] orderItemId,HttpSession httpSession){
        //存放OrderItem的列表对象
        List<OrderItem> orderItems = new ArrayList<>();
        //总价
        int total = 0;
        for (int oiid :orderItemId){
            //取出对应的OrderItem
            OrderItem orderItem = orderItemService.get(oiid);
            /**
             * 测试输出
             */
//            System.out.println(orderItem);
            //计算总额
            total += (orderItem.getProduct().getPromotePrice() * orderItem.getNumber()) ;
            //添加到OrderItem的列表
            orderItems.add(orderItem);
        }
        //增加页面属性
        httpSession.setAttribute("orderItems",orderItems);
        model.addAttribute("total",total);
        return "fore/Settlement";
    }

    /**
     * 添加到购物车的逻辑方法
     * 1、在已有的orderItem中搜索需要添加的商品
     *      1）、如果OrderItem中已经存在该商品，则直接增加购买数量
     *      2)、如果OrderItem中不存在该商品，则新建OrderItem对象
     * @return
     */
    @ResponseBody
    @PostMapping("/addCart")
    private String addCart(int pid,int num,HttpSession httpSession){
        //获取该商品实例
        Product product = productService.get(pid);
        //获取登录的用户信息
        User user = (User) httpSession.getAttribute("user");
        //获取用户对应的所有订单项信息
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        //初始化临时标志符
        boolean flag = false;   //默认初始化为false,如果不声明在编译前报错
        //遍历所有的订单并查找
        for (OrderItem orderItem : orderItems){
            //如果id相同 说明已经存在该商品
            if(orderItem.getPid().equals(product.getId())){
                //增加订单中的购买数目
                orderItem.setNumber(orderItem.getNumber()+num);
                //更新订单项信息
                orderItemService.update(orderItem);
                //更改临时标志符
                flag =true;
                //跳出遍历循环
                break;
            }
        }
        //flag仍然为false，则订单项不存在
        if (!flag){
            //新建OrderItem实例
            OrderItem orderItem = new OrderItem();
            //填充各类数据
            orderItem.setUid(user.getId());
            orderItem.setNumber(num);
            orderItem.setPid(pid);
            //添加到数据库
            orderItemService.add(orderItem);
        }
        return "success";
    }

    @PostMapping("/changeNumber")
    @ResponseBody
    private String changeProductNumber(int num,int oiid){
        //此处为第一次使用user获取所有的orderItem遍历的代码
        //     //1、取出User对象
        //        User user = (User)httpSession.getAttribute("user");
        //        if(user == null){
        //            return "fail";
        //        }
        //        //2、取出所有OrderItem
        //        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        //        //3、遍历所有OrderItem
        //        for (OrderItem orderItem
        //                :orderItems) {
        //            //4、找到Pid一致的OrderItem
        //            if(orderItem.getPid() == pid){
        //                //5、修改num
        //                orderItem.setNumber(num);
        //                //6、更新OrderItem
        //                orderItemService.update(orderItem);
        //                //7、直接退出
        //                break;
        //            }
        //        }
        //直接使用oiid修改OrderItem

        //1.通过oiid取出OrderItem实例对象
        OrderItem orderItem = orderItemService.get(oiid);
        //2.修改OrderItem的Number属性
        orderItem.setNumber(num);
        //3.完成更新操作
        orderItemService.update(orderItem);
        return "success";
    }


    @ResponseBody
    @RequestMapping("/deleteOrderItem")
    private String deleteOrderItem(int oiid,HttpSession httpSession){
        //调用OrderItemService方法删除
        orderItemService.delete(oiid);
        return "success";
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

    @RequestMapping("/createOrder")
    private String CreateOrder(Model model,Order order,HttpSession httpSession){
        //Perfect the order parameter;
        //Generate a random number as orderCode;
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
        order.setOrderCode(orderCode);
        //Fill createDate;
        order.setCreateDate(new Date());
        //Fill uid;
        User user = (User)httpSession.getAttribute("user");
        order.setUid(user.getId());
        //Change status to waitPay;
        order.setStatus(OrderService.waitPay);
        //Get all OrderItem information from session;
        List<OrderItem> orderItems = (List<OrderItem>) httpSession.getAttribute("orderItems");
        //Get the total price and redirect to the pay page;
        float total = orderService.add(order,orderItems);
        return "redirect:alipay?oid="+order.getId()+"&total="+total;
    }

    @RequestMapping("/payed")
    private String Payed(int orderId,float total, Model model){
        //Get the order information as a Object
        Order order = orderService.get(orderId);
        //Change payDate and status
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        //Update database
        orderService.update(order);
        //Add the attribute
        model.addAttribute("order",order);
        //jump
        return "fore/Payed";
    }


    @RequestMapping("/bought")
    private String Bought(Model model,HttpSession session){
        //Get the id of the login user
        User user =  (User)session.getAttribute("user");
        int id = user.getId();
        //Get all order information of this use and exclude the Status is Delete
        List<Order> orders = orderService.list(id,OrderService.delete);
        //Fill
        orderService.loadOrder(orders);
//        System.out.println(orders.get(1).getOrderItems().size());
        model.addAttribute("orders",orders);
        return "fore/Bought";
    }

    /**
     * 获取相应order并跳转到确认收货页面
     * @param oid
     * @return
     */
    @RequestMapping("/confirmPay")
    @ResponseBody
    private String confirmPay(int oid,Model model){
        //获取Order
        Order order = orderService.get(oid);
        //选择性属性填充
        orderService.loadOrder(order);
        //设置页面属性
        model.addAttribute("order",order);
        return "fore/confirmPay";
    }

    @PostMapping("/deleteOrder")
    @ResponseBody
    private String DeleteOrder(int oid){
        //Get the order object.
        Order order = orderService.get(oid);
        //Modify  the status attribute.
        order.setStatus(OrderService.delete);
        //Update
        orderService.update(order);

        return "success";
    }
}















