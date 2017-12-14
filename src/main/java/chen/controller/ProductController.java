package chen.controller;

import chen.dto.Result;
import chen.entity.Category;
import chen.entity.Product;
import chen.service.CategoryService;
import chen.service.ProductService;
import chen.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Create by chen on 17-11-10
 */
@Controller
@RequestMapping("/admin")
public class ProductController {
    private static final String URL = "/product";
    private final ProductService productService;
    private final CategoryService categoryService;

    @Autowired
    public ProductController(ProductService productService,CategoryService categoryService) {
        this.productService = productService;
        this.categoryService = categoryService;
    }

    @GetMapping(URL)
    private String get(int cid,Model model,Page page){
        //获取相应的分类信息
        Category category = categoryService.get(cid);
        //设置分页
        PageHelper.offsetPage(page.getStart(),page.getCount());
        //根据cid获取全部的product信息
        List<Product> productList = productService.list(cid);
        //计算页面总数
        page.setTotal((int) new PageInfo<>(productList).getTotal());
        //添加页面属性
        model.addAttribute("products",productList);
        model.addAttribute("page",page);
        model.addAttribute  ("category",category);
        return "admin/Product";
    }

    @DeleteMapping(URL)
    @ResponseBody
    private Result delete(@RequestParam("id") int id){
        productService.delete(id);
        return new Result();
    }

    @PutMapping(URL)
    @ResponseBody
    private Result update(Product product){
        productService.update(product);
        return new Result();
    }

    @PostMapping(URL)
    @ResponseBody
    private Result add(Product product){
        productService.add(product);
        return new Result();
    }
}
