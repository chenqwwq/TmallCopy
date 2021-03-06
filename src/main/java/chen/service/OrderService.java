package chen.service;

import chen.entity.Order;
import chen.entity.OrderItem;
import chen.entity.User;

import java.util.List;

public interface OrderService {
    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";

    void loadOrder(Order order);
    void loadOrder(List<Order> orders);
    List<Order> list();
    Order get(int id);
    void delete(int id);
    void add(Order order);
    float add(Order order,List<OrderItem> orderItems);
    void update(Order order);
    void loadWaitPayCount(User user);           //加载所有的等待付款的订单作为购物车项目
    List<Order> list(int uid,String excludedStatus);
}