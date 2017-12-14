package chen.service;

import chen.entity.Category;
import chen.entity.Product;

import java.util.List;

/**
 * Create by "chen" on 17-11-10
 */
public interface ProductService {
    void add(Product product);
    void delete(int id);
    void update(Product product);
    Product get(int id);
    List<Product> list(int cid);
    void setFirstProductImage(Product product);
    void fill(Category category);
    void fill(List<Category> categories);
    void fillByGroup(List<Category> categories);
}
