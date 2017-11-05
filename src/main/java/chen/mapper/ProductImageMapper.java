package chen.mapper;

import chen.entity.ProductImage;
import java.util.List;

public interface ProductImageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ProductImage record);

    ProductImage selectByPrimaryKey(Integer id);

    List<ProductImage> selectAll();

    int updateByPrimaryKey(ProductImage record);
}