package chen.service.impl;

import chen.entity.OrderItem;
import chen.entity.OrderItemExample;
import chen.entity.Product;
import chen.entity.ProductImage;
import chen.mapper.OrderItemMapper;
import chen.mapper.ProductMapper;
import chen.service.OrderItemService;
import chen.service.ProductImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemServiceImpl implements OrderItemService{

    private final OrderItemMapper orderItemMapper;
    private final ProductImageService productImageService;
    /**
     *   此处直接Autowired,结果出现了BeanCurrentlyInCreationException, 是循环依赖导致
     *      因此改为用productMapper
     */
    private final ProductMapper productMapper;
//    private final ProductService productService;

    @Autowired
    public OrderItemServiceImpl(OrderItemMapper orderItemMapper, ProductImageService productImageService, ProductMapper productMapper) {
        this.orderItemMapper = orderItemMapper;
        this.productImageService = productImageService;
        this.productMapper = productMapper;
    }

    @Override
    public List<OrderItem> list(int oid) {
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andOidEqualTo(oid);
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        LoadOther(orderItems);
        return orderItems;
    }

    @Override
    public List<OrderItem> list() {
        //创建筛选条件
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.setOrderByClause("id desc");
        List<OrderItem> orders = orderItemMapper.selectByExample(orderItemExample);
        //遍历orders,获取并装载product order
        LoadOther(orders);
        return orders;
    }

    /**
     * 加载oderItem属性中的order和product
     * @param orderItem
     */
    private void LoadOther(OrderItem orderItem){
        //因为使用ProductService获取会导致循环依赖 所以使用productMapper
        Product product = productMapper.selectByPrimaryKey(orderItem.getPid());
        //另外加载ProductImage
        List productImages = productImageService.list(product.getId(),ProductImageService.type_single);
        product.setFirstProductImage(productImages.isEmpty()?null:(ProductImage) productImages.get(0));
        //获取OrderIte对应的order
        orderItem.setProduct(product);
    }

    private void LoadOther(List<OrderItem> orderItems){
        for(OrderItem orderItem : orderItems)
            LoadOther(orderItem);
    }


    @Override
    public OrderItem get(int id) {
        //获取orderItem
        OrderItem orderItem = orderItemMapper.selectByPrimaryKey(id);
        //装载Product 和 Order
        LoadOther(orderItem);
        return orderItem;
    }

    @Override
    public void delete(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void add(OrderItem orderItem) {
        orderItemMapper.insert(orderItem);
    }

    @Override
    public void update(OrderItem orderItem) {
        orderItemMapper.updateByPrimaryKey(orderItem);
    }

    @Override
    public int getSaleCount(int pid) {
        //创建OrderItem的搜索条件
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria()
                .andPidEqualTo(pid);
        //获取所有对应的OrderItem
        List<OrderItem> orderItems = orderItemMapper.selectByExample(orderItemExample);
        //计算全部number的总和
        int count = 0;
        for (OrderItem orderItem : orderItems)
            count += orderItem.getNumber();
        return count;
    }

    @Override
    public List<OrderItem> listByUser(int uid) {
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria()
                .andUidEqualTo(uid);
        List<OrderItem> result = orderItemMapper.selectByExample(orderItemExample);
        LoadOther(result);
        return result;
    }
}
