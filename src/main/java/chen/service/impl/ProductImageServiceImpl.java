package chen.service.impl;

import chen.entity.ProductImage;
import chen.entity.ProductImageExample;
import mapper.ProductImageMapper;
import chen.service.ProductImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProductImageServiceImpl implements ProductImageService{

    private final ProductImageMapper productImageMapper;

    @Autowired
    public ProductImageServiceImpl(ProductImageMapper productImageMapper) {
        this.productImageMapper = productImageMapper;
    }

    @Override
    public void add(ProductImage productImage) {
        productImageMapper.insert(productImage);
    }

    @Override
    public void delete(int id) {
        productImageMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(ProductImage productImage) {
        productImageMapper.updateByPrimaryKey(productImage);
    }

    @Override
    public ProductImage get(int id) {
        return productImageMapper.selectByPrimaryKey(id);
    }

    @Override
    public List list(int productId, String type) {
        ProductImageExample productImageExample = new ProductImageExample();
        productImageExample.setOrderByClause("id desc");
        productImageExample.createCriteria()
                .andPidEqualTo(productId)
                .andTypeEqualTo(type);
        return productImageMapper.selectByExample(productImageExample);
    }
}
