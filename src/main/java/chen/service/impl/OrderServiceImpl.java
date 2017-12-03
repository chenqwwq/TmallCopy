package chen.service.impl;
/**
 * 在订单管理页面中按照用户分别显示
 * LoadOther
 *      需要user信息和OrderItem的list
 */

import chen.entity.Order;
import chen.entity.OrderExample;
import chen.entity.OrderItem;
import chen.mapper.OrderMapper;
import chen.service.OrderItemService;
import chen.service.OrderService;
import chen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class OrderServiceImpl implements OrderService{

    private final OrderMapper orderMapper;
    private final UserService userService;
    private final OrderItemService orderItemService;

    @Autowired
    public OrderServiceImpl(OrderMapper orderMapper, UserService userService, OrderItemService orderItemService) {
        this.orderMapper = orderMapper;
        this.userService = userService;
        this.orderItemService = orderItemService;
    }

    @Override
    public List<Order> list() {
        OrderExample orderExample = new OrderExample();
        orderExample.setOrderByClause("id desc");
        List<Order> orders =  orderMapper.selectByExample(orderExample);
        LoadOther(orders);  //加载非数据库属性
        return orders;
    }

    /**
     * 装载User和OrderItem
     * @param orders
     */
    private void LoadOther(List<Order> orders){
        for (Order order:orders)
            LoadOther(order);
    }
    private void LoadOther(Order order){
        order.setUser(userService.get(order.getUid()));
        order.setOrderItems(orderItemService.list());
    }

    /**
     * 计算Order的各类统计信息
     *  总数目
     *  总金额
     *      此处和网站上有些出入,因为OrderItem中的Product是在list或者get的时候直接通过调用LoadOther
     * 填充的。没有将该方法置于orderItemService中
     * @param order
     */
    @Override
    public void fillOrder(Order order){
        List<OrderItem> orderItems = order.getOrderItems();
        int num = 0;
        float total = 0.0f;
        for (OrderItem orderItem:orderItems){
            total+=orderItem.getProduct().getPromotePrice()*orderItem.getNumber();
            num+=orderItem.getNumber();
        }
        order.setNum(num);
        order.setTotal(total);
    }

    @Override
    public Order get(int id) {
        Order order = orderMapper.selectByPrimaryKey(id);
        LoadOther(order);
        return order;
    }

    @Override
    public void delete(int id) {
        orderMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void add(Order order) {
        orderMapper.insert(order);
    }

    @Override
    public void update(Order order) {
        orderMapper.updateByPrimaryKey(order);
    }
}
