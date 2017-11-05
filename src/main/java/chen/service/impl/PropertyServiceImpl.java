package chen.service.impl;

import chen.entity.Property;
import chen.mapper.PropertyMapper;
import chen.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create by chen on 17-11-4
 */
@Service
public class PropertyServiceImpl implements PropertyService {

    private final PropertyMapper propertyMapper;

    @Autowired
    public PropertyServiceImpl(PropertyMapper propertyMapper) {
        this.propertyMapper = propertyMapper;
    }

    @Override
    public void add(Property property) {
        propertyMapper.insert(property);
    }

    @Override
    public void delete(int id) {
        propertyMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Property property) {
        propertyMapper.updateByPrimaryKey(property);
    }

    @Override
    public Property get(int id) {
        return propertyMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Property> list(int cid) {
        return propertyMapper.selectAll(cid);
    }
}
