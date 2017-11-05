package chen.mapper;

import chen.entity.PropertyValue;
import java.util.List;

public interface PropertyValueMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(PropertyValue record);

    PropertyValue selectByPrimaryKey(Integer id);

    List<PropertyValue> selectAll();

    int updateByPrimaryKey(PropertyValue record);
}