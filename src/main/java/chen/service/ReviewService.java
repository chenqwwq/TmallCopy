package chen.service;

import chen.entity.Review;

import java.util.List;

public interface ReviewService {
    Review get(int id);
    void add(Review review);
    void delete(int id);
    void update(Review review);
    List<Review> list();

    int getCount();
    //统计Pid下的所有评论数目
    int getCount(int pid);
    //获取Pid对应的所有Review
    List<Review> listByPid(int pid);
    //在必要时装配User属性
    void LoadUser(Review review);
    void LoadUser(List<Review> reviews);
}
