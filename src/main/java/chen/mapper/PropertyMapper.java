package chen.mapper;

import chen.entity.Property;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PropertyMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Property record);

    Property selectByPrimaryKey(Integer id);

    List<Property> selectAll(Integer cid);

    int updateByPrimaryKey(Property record);
}