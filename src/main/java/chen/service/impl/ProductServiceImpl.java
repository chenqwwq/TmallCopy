package chen.service.impl;

import chen.entity.Product;
import chen.entity.ProductExample;
import chen.mapper.CategoryMapper;
import chen.mapper.ProductMapper;
import chen.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create by "chen" on 17-11-10
 */
@Service
public class ProductServiceImpl implements ProductService {

    private final ProductMapper productMapper;
    private final CategoryMapper categoryMapper;

    @Autowired
    public ProductServiceImpl(ProductMapper productMapper, CategoryMapper categoryMapper) {
        this.productMapper = productMapper;
        this.categoryMapper = categoryMapper;
    }


    @Override
    public void add(Product product) {
        productMapper.insert(product);
    }

    @Override
    public void delete(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Product product) {
        productMapper.updateByPrimaryKey(product);
    }

    @Override
    public Product get(int id) {
        //获取产品信息
        Product product = productMapper.selectByPrimaryKey(id);
        //通过产品信息中的cid获取相应的分类信息
        product.setCategory(categoryMapper.selectByPrimaryKey(product.getCid()));
        return product;
    }

    @Override
    public List<Product> list(int cid) {
        ProductExample productExample = new ProductExample();
        productExample.setOrderByClause("id desc");
        productExample.createCriteria().andCidEqualTo(cid);
        return productMapper.selectByExample(productExample);
    }
}
