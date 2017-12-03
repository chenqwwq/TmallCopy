package chen.service;

import chen.entity.Product;
import chen.entity.PropertyValue;

import java.util.List;

public interface PropertyValueService {
    void init(Product p);
    void update(PropertyValue propertyValue);

    PropertyValue get(int ptid, int pid);
    List<PropertyValue> list(int pid);
}
