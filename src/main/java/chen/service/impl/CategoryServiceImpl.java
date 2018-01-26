package chen.service.impl;

import chen.entity.Category;
import chen.entity.CategoryExample;
import chen.entity.Product;
import chen.mapper.CategoryMapper;
import chen.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Create by chen on 17-11-1
 */
@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryMapper categoryMapper;

    @Autowired
    public CategoryServiceImpl(CategoryMapper categoryMapper) {
        this.categoryMapper = categoryMapper;
    }

    @Override
    public List<Category> list() {
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.setOrderByClause("id desc");
        return categoryMapper.selectByExample(categoryExample);
    }

    @Override
    public void delete(int id) {
        categoryMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void add(Category category) {
        categoryMapper.insert(category);
    }

    @Override
    public Category get(int id) {
        return categoryMapper.selectByPrimaryKey(id);
    }

    @Override
    public void update(Category category) {
        categoryMapper.updateByPrimaryKey(category);
    }

    @Override
    public void loadCategory(Product product) {
        //通过product的id获取对应分类
       product.setCategory(get(product.getId()));
    }
}
