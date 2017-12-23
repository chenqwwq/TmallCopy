package chen.service.impl;

import chen.entity.User;
import chen.entity.UserExample;
import chen.mapper.UserMapper;
import chen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    @Autowired
    public UserServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
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
