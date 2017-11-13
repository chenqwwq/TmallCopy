package chen.controller;

import chen.entity.Product;
import chen.service.ProductImageService;
import chen.service.ProductService;
import chen.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class ProductImageController {
    private final String URL = "/productImage";
    private final ProductImageService productImageService;
    private final ProductService productService;

    @Autowired
    public ProductImageController(ProductImageService productImageService, ProductService productService) {
        this.productImageService = productImageService;
        this.productService = productService;
    }

    @GetMapping(URL)
    private String productImage(int pid, Model model){
        //数据获取
        Product product = productService.get(pid);      //通过get获取的product包含了对应的category对象
        //根据类别不同分别获取图片
        List productImages_single = productImageService.list(pid,ProductImageService.type_single);
        List productImages_detail = productImageService.list(pid,ProductImageService.type_detail);
        //添加到页面属性
        model.addAttribute("product",product);
        model.addAttribute("productImage_single",productImages_single);
        model.addAttribute("productImage_detail",productImages_detail);

        return "admin/ProductImage";
    }
}
