package chen.mapper;

import chen.entity.Review;
import java.util.List;

public interface ReviewMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Review record);

    Review selectByPrimaryKey(Integer id);

    List<Review> selectAll();

    int updateByPrimaryKey(Review record);
}