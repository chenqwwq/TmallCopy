package chen.service;

import chen.entity.Product;
import chen.entity.ProductImage;

import java.util.List;

public interface ProductImageService {
    String type_single = "type_single";
    String type_detail = "type_detail";

    void add(ProductImage productImage);
    void delete(int id);
    void update(ProductImage productImage);
    ProductImage get(int id);
    List<ProductImage> list(int pid,String type);

    //加载所有指定类型ProductImage到product
    void LoadImage(Product product,String type);
}
