package chen.controller;
/**
 * 后台订单管理页面的后台操作
 * 订单的页面中：
 *      OrderItem(订单项)中的oid指向Order(订单内容)
 *                          uid指向User(用户)
 *                          pid指向Product(产品)
 * 其中Order是主导地位,Order中包含了orderItem
 * productService的setFirstProductImage()方法，用于指定image在订单页面显示
 */

import chen.entity.Order;
import chen.service.OrderItemService;
import chen.service.OrderService;
import chen.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class OrderController {
    private static final String URL = "/order";
    private final OrderService orderService;
    private final OrderItemService orderItemService;

    @Autowired
    public OrderController(OrderService orderService, OrderItemService orderItemService) {
        this.orderService = orderService;
        this.orderItemService = orderItemService;
    }

    @GetMapping(URL)
    private String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Order> orderList = orderService.list();
        page.setTotal((int) new PageInfo<>(orderList).getTotal());
        for (Order order : orderList) {
            orderService.fillOrder(order);
        }
        model.addAttribute("page",page);
        model.addAttribute("orderList",orderList);
        return "admin/Order";
    }

    @RequestMapping("orderDelivery")
    public String delivery(Order o) throws IOException {
        o.setDeliveryDate(new Date());
        o.setStatus(OrderService.waitConfirm);
        orderService.update(o);
        return "redirect:admin/Order";
    }

    private void show(List list){
        for (Object o : list)
            System.out.println(o);
    }

}
