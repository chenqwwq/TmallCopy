package chen.service;

import chen.entity.Order;

import java.util.List;

public interface OrderService {
    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";

    void fillOrder(Order order);
    List<Order> list();
    Order get(int id);
    void delete(int id);
    void add(Order order);
    void update(Order order);
}
