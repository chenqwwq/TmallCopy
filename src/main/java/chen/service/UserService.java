package chen.service;

import chen.entity.User;

import java.util.List;

public interface UserService {
    void add(User user);
    void update(User user);
    void delete(int id);
    List<User> list();
    User get(int id);
}
