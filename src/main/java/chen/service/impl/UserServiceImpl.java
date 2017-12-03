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
}
