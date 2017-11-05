package chen.controller;

import chen.dto.Result;
import chen.entity.Category;
import chen.service.CategoryService;
import chen.util.ImageUtil;
import chen.util.Page;
import chen.util.UploadedImageFile;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Create by chen on 17-11-1
 */
@Controller
@RequestMapping("/admin")
public class CategoryController {
    private static final String URL = "/category";

    private final CategoryService categoryService;

    @Autowired
    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping(URL)
    private String category(Model model,Page page){
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Category> list = categoryService.list();       //得到相应数据
        page.setTotal((int)new PageInfo<>(list).getTotal());
        if(list.size() > 0)
            model.addAttribute("categories",list);
        model.addAttribute("page",page);
        return "admin/listCategory";
    }

    @DeleteMapping(URL)
    @ResponseBody
    private Result delete(@RequestParam int id,HttpSession session){
        System.out.println("进入delete方法"+id);
        categoryService.delete(id);     //删除数据库中的分类信息
        /**
         *  ServletContext是一个全局的信息存储空间
         *request一个请求一个,session一个会话一个,但是ServletContext是所有用户请求共享的.
         *删除对应的图片文件
         */
        File file = new File(new File(session.getServletContext().getRealPath("img/category")),id+".jpg");
        return file.exists()?(file.delete()?new Result():new Result("文件删除错误")):new Result();
    }
    @PostMapping(URL)
    private String add(@RequestParam("name") String name, HttpSession session, UploadedImageFile uploadedImageFile) throws IOException {
        /**
         * 因为此时的category除了name没有别的信息,
         *    所以需要新对象 用来接收插入操作之后的获得的id */
        Category category = new Category();
        category.setName(name);     //创建新的Category对象
        categoryService.add(category);          //增加操作的核心步骤
        File file = new File(new File(session.getServletContext().getRealPath("img/category")),
                category.getId()+".jpg");    //获取存储照片的真实文件位置
        if(!file.getParentFile().exists())
            file.getParentFile().mkdirs();
        uploadedImageFile.getImage().transferTo(file);
        BufferedImage img = ImageUtil.change2jpg(file);
        ImageIO.write(img, "jpg", file);
        return "redirect:/admin/category";
    }

    private void show(List list){
        for(Object object : list){
            System.out.println(object);
        }
    }
}
