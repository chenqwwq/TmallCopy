package chen.service.impl;

import chen.entity.Review;
import chen.entity.ReviewExample;
import chen.mapper.ReviewMapper;
import chen.service.ReviewService;
import chen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewMapper reviewMapper;
    private final UserService userService;

    @Autowired
    public ReviewServiceImpl(ReviewMapper reviewMapper, UserService userService) {
        this.reviewMapper = reviewMapper;
        this.userService = userService;
    }

    @Override
    public Review get(int id) {
        return reviewMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Review> listByPid(int pid) {
        //创建查找条件
        ReviewExample reviewExample = new ReviewExample();
        reviewExample.createCriteria()
                .andPidEqualTo(pid);
        return reviewMapper.selectByExample(reviewExample);
    }

    @Override
    public void LoadUser(Review review) {
        review.setUser(userService.get(review.getUid()));
    }

    @Override
    public void LoadUser(List<Review> reviews) {
        for (Review review : reviews)
            LoadUser(review);
    }

    @Override
    public int getCount() {
        return list().size();
    }

    @Override
    public int getCount(int pid) {
        return listByPid(pid).size();
    }

    @Override
    public void add(Review review) {
        reviewMapper.insert(review);
    }

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Review review) {
        reviewMapper.updateByPrimaryKey(review);
    }

    @Override
    public List<Review> list() {
        ReviewExample reviewExample = new ReviewExample();
        reviewExample.createCriteria()
                .andIdIsNotNull();
        return reviewMapper.selectByExample(reviewExample);
    }
}
