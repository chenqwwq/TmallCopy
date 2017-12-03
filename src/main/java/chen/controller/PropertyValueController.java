package chen.controller;

import chen.dto.Result;
import chen.entity.Product;
import chen.entity.PropertyValue;
import chen.service.ProductService;
import chen.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/admin")
public class PropertyValueController {
    private static final  String URL = "/propertyValue";
    private final PropertyValueService propertyValueService;
    private final ProductService productService;

    @Autowired
    public PropertyValueController(PropertyValueService propertyValueService, ProductService productService) {
        this.propertyValueService = propertyValueService;
        this.productService = productService;
    }

    @GetMapping(URL)
    private String list(int pid, Model model){
        Product product = productService.get(pid);      //获取pid对应的商品数据 并封装为对象
        //初始化操作属性
        propertyValueService.init(product);
        //初始化之后在获取product对应的全部属性

        model.addAttribute("product",product);
        model.addAttribute("propertyValues",propertyValueService.list(pid));
        return "admin/PropertyValue";
    }

    @PutMapping(URL)
    @ResponseBody
    private Result update(PropertyValue propertyValue){
        System.out.println(propertyValue);
        propertyValueService.update(propertyValue);
        return new Result();
    }

}
