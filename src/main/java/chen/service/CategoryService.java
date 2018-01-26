package chen.service;

import chen.entity.Category;
import chen.entity.Product;

import java.util.List;

/**
 * Create by chen on 17-11-1
 */
public interface CategoryService {
    List<Category> list();          //查询全部
    Category get(int id);               //查询
    void delete(int id);            //删除
    void add(Category category);    //增加
    void update(Category category); //更新
    void loadCategory(Product product);//加载分类信息
}
