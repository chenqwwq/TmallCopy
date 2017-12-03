package chen.service.impl;

import chen.entity.Product;
import chen.entity.Property;
import chen.entity.PropertyValue;
import chen.entity.PropertyValueExample;
import chen.mapper.PropertyValueMapper;
import chen.service.PropertyService;
import chen.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PropertyValueServiceImpl implements PropertyValueService {

    private final PropertyValueMapper propertyValueMapper;
    private final PropertyService propertyService;

    @Autowired
    public PropertyValueServiceImpl(PropertyValueMapper propertyValueMapper, PropertyService propertyService) {
        this.propertyValueMapper = propertyValueMapper;
        this.propertyService = propertyService;
    }

    /**
     * 初始化操作
     * 每个商品都具有的一些属性 即使为null
     * @param p
     */
    @Override
    public void init(Product p) {
        List<Property> pts = propertyService.list(p.getCid());

        //遍历商品的每一个属性
        for (Property pt: pts) {
            //获取属性对应的属性值 如果为空则初始化
            PropertyValue pv = get(pt.getId(),p.getId());
            if(null==pv){
                pv = new PropertyValue();
                pv.setPid(p.getId());
                pv.setPtid(pt.getId());
                propertyValueMapper.insert(pv);
            }
        }

    }

    @Override
    public void update(PropertyValue propertyValue) {
        propertyValueMapper.updateByPrimaryKeySelective(propertyValue);
    }

    /**
     * 根据产品和属性id获取一个属性的值
     * @param ptid  属性id
     * @param pid   产品id
     * @return
     */
    @Override
    public PropertyValue get(int ptid, int pid) {
        //创建Mybatis的Example实例
        PropertyValueExample example = new PropertyValueExample();
        //指定搜索标准
        example.createCriteria()
                .andPidEqualTo(pid)
                .andPtidEqualTo(ptid);
        List<PropertyValue> list = propertyValueMapper.selectByExample(example);
        return list==null?null:list.get(0);
    }

    /**
     * 注意！！在其中还需要赋予property属性
     * @param pid
     * @return
     */
    @Override
    public List<PropertyValue> list(int pid) {
        PropertyValueExample propertyValueExample = new PropertyValueExample();
        propertyValueExample.createCriteria()
                .andPidEqualTo(pid);
        List<PropertyValue> propertyValues = propertyValueMapper.selectByExample(propertyValueExample);
        //遍历获得的propertyValue列表 为每个元素获取property
        for (PropertyValue propertyValue : propertyValues)
            propertyValue.setProperty(propertyService.get(propertyValue.getPtid()));
        return propertyValues;
    }
}
