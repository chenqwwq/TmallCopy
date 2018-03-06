package chen.service;

import chen.entity.OrderItem;

import java.util.List;

public interface OrderItemService {
    List<OrderItem> list(int oid);
    List<OrderItem> list();
    OrderItem get(int id);
    void delete(int id);
    void add(OrderItem orderItem);
    void update(OrderItem orderItem);
    int getSaleCount(int pid);
    List<OrderItem> listByUser(int uid);
}
