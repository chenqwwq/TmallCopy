package chen.controller;

import chen.dto.Result;
import chen.entity.Category;
import chen.entity.Property;
import chen.service.CategoryService;
import chen.service.PropertyService;
import chen.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Create by chen on 17-11-4
 */
@Controller
@RequestMapping("/admin")
public class PropertyController {
    private static final String URL = "/property";
    private final CategoryService categoryService;
    private final PropertyService propertyService;

    @Autowired
    public PropertyController(PropertyService propertyService,CategoryService categoryService){
        this.propertyService = propertyService;
        this.categoryService = categoryService;
    }

    @GetMapping(URL)
    private String get(@RequestParam("cid") int cid, Model model,Page page){
        //获取相应类型信息
        Category category = categoryService.get(cid);
        //分页机制
        PageHelper.offsetPage(page.getStart(),page.getCount());
        //获取属性该类的属性列表
        List<chen.entity.Property> properties = propertyService.list(cid);
        //向page注入page总数
        page.setTotal((int) new PageInfo<>(properties).getTotal());
        //页面属性添加
        model.addAttribute("properties",properties);
        model.addAttribute("page",page);
        model.addAttribute("category",category);
        return "/admin/Property";
    }

    @DeleteMapping(URL)
    @ResponseBody
    private Result delete( int cid,@RequestParam int pid){
        propertyService.delete(pid);        //删除的核心操作
        return new Result();
    }

    @PostMapping(URL)
    @ResponseBody
    private Result add(Property property){
        propertyService.add(property);
        return new Result();
    }


    @PutMapping("/property")
    @ResponseBody
    private Result update(Property property){
        propertyService.update(property);
        return new Result();
    }
}
