package chen.service.impl;

import chen.entity.*;
import chen.mapper.CategoryMapper;
import chen.mapper.ProductMapper;
import chen.service.OrderItemService;
import chen.service.ProductImageService;
import chen.service.ProductService;
import chen.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.FormatFlagsConversionMismatchException;
import java.util.List;

/**
 * Create by "chen" on 17-11-10
 */
@Service
public class ProductServiceImpl implements ProductService {

    //页面显示分组大小
    private static final int productGroupNum =8;

    private final ProductMapper productMapper;
    private final CategoryMapper categoryMapper;
    private final ProductImageService productImageService;
    private final OrderItemService orderItemService;
    private final ReviewService reviewService;

    @Autowired
    public ProductServiceImpl(ProductMapper productMapper, CategoryMapper categoryMapper, ProductImageService productImageService, OrderItemService orderItemService, ReviewService reviewService) {
        this.productMapper = productMapper;
        this.categoryMapper = categoryMapper;
        this.productImageService = productImageService;
        this.orderItemService = orderItemService;
        this.reviewService = reviewService;
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
        //设置图片
        setFirstProductImage(product);
        return product;
    }

    @Override
    public List<Product> list(int cid) {
        ProductExample productExample = new ProductExample();
        productExample.setOrderByClause("id desc");
        productExample.createCriteria().andCidEqualTo(cid);
        //获取所有的商品
        List<Product> products =productMapper.selectByExample(productExample);
        //需要在订单页面显示图片 预先设置
        setFirstProductImage(products);
        return products;
    }

    @Override
    public void setFirstProductImage(Product product) {
        //获取所有的单个图片
        List productImages = productImageService.list(product.getId(),ProductImageService.type_single);
        product.setFirstProductImage(productImages.isEmpty()?null:(ProductImage) productImages.get(0));
    }

    @Override
    public void setFirstProductImage(List<Product> products) {
        for (Product product : products)
            setFirstProductImage(product);
    }


    /**
     * Product的填充方法
     */
    @Override
    public void fill(Category category) {
        //利用本地的list方法取出所有的product并注入
        category.setProducts(list(category.getId()));
    }

    @Override
    public void fill(List<Category> categories) {
        for (Category category:categories)
            fill(category);
    }

    /**
     * 因为在页面上显示的时候是分组的所以提前在此处分组
     *      category的List<List<Category>>属性就是分组的分组
     * @param categories
     */
    @Override
    public void fillByGroup(List<Category> categories) {
        for (Category category : categories){
            //获取分类中的所有商品信息
            List<Product> products;
            if((products = category.getProducts()) == null){
                products = list(category.getId());
            }
            //创建临时存储对象
            List<List<Product>> productByGroup = new ArrayList<>();
            //for循环遍历全部products
            for (int i = 0;i < products.size();i += productGroupNum){
                //range是product分组的范围
                int range = i + productGroupNum;
                range = range > products.size()?products.size():range;
                //利用subList在products中获取sublist
                productByGroup.add(products.subList(i,range));
            }
            //属性填充
            category.setGroupProducts(productByGroup);
        }
    }

    @Override
    public void setSaleAndReviewNumber(Product product) {
        product.setSaleCount(orderItemService.getSaleCount(product.getId()));
        product.setReviewCount(reviewService.getCount(product.getId()));
    }

    @Override
    public void setSaleAndReviewNumber(List<Product> products) {
        for (Product product:products)
            setSaleAndReviewNumber(product);
    }

    @Override
    public List<Product> search(String keyword) {
        //创建筛选条件
        ProductExample example = new ProductExample();
        //模糊查询
        example.createCriteria().andNameLike("%" + keyword + "%");
        //正序排列
        example.setOrderByClause("id desc");
        //获得结果
        List<Product> result = productMapper.selectByExample(example);
        //填充结果
        setFirstProductImage(result);
        return result;
    }

}
