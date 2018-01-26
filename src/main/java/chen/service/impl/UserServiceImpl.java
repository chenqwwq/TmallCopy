package chen.service.impl;

import chen.entity.User;
import chen.entity.UserExample;
import chen.mapper.UserMapper;
import chen.service.OrderItemService;
import chen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private OrderItemService orderItemService;

    @Autowired
    public UserServiceImpl(UserMapper userMapper, OrderItemService orderItemService) {
        this.userMapper = userMapper;
        this.orderItemService = orderItemService;
    }

    @Override
    public void add(User user) {
        userMapper.insert(user);
    }

    @Override
    public void update(User user) {
        userMapper.updateByPrimaryKey(user);
    }

    @Override
    public void delete(int id) {
        userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<User> list() {
        UserExample userExample = new UserExample();
        userExample.createCriteria()
                .andIdIsNotNull();
        return userMapper.selectByExample(userExample);
    }

    @Override
    public User get(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    /**
     * 加载非数据库数据
     */
    private void LoadOther(User user){
        //加载订单数量
        /**
         * 此处简单获取user对应的OrderItem的数目作为购物车件数
         */
        user.setWaitPayOrderCount(orderItemService.listByUser(user.getId()).size());
    }

    private void LoadOther(List<User> users){
        for (User user : users)
            LoadOther(user);
    }


    @Override
    public boolean verify(String user) {
        //创建搜索条件
        UserExample userExample = new UserExample();
        userExample.createCriteria().andNameEqualTo(user);
        //获取所有匹配数据
        List<User> users = userMapper.selectByExample(userExample);
        //判断并返回一个User对象 用于验证登录
        return users.size() == 1;
    }

    @Override
    public User verify(String name, String password) {
        //创建搜索条件
        UserExample userExample = new UserExample();
        userExample.createCriteria()
                .andNameEqualTo(name)
                .andPasswordEqualTo(password);
        //搜索并匹配
        List<User> users = userMapper.selectByExample(userExample);
        return users.size() == 1?users.get(0):null;
    }
}
