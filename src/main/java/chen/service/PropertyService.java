package chen.service;

import chen.entity.Property;

import java.util.List;

/**
 * Create by chen on 17-11-4
 */
public interface PropertyService {
    void add(Property property);    //增加
    void delete(int id);            //删除
    void update(Property property); //更新
    Property get(int id);           //获取
    List<Property> list(int cid);   //按照分类id(cid)查询属性
}
