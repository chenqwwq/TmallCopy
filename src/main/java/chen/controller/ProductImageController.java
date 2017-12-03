package chen.controller;

import chen.dto.Result;
import chen.entity.Product;
import chen.entity.ProductImage;
import chen.service.ProductImageService;
import chen.service.ProductService;
import chen.util.ImageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.List;

import static chen.util.ImageUtil.*;

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

    @PostMapping(URL)
    private String add(ProductImage productImage,MultipartFile image, HttpSession session){
        productImageService.add(productImage);
        System.out.println(productImage);       //输出测试
        //设置图片在后端的名字 id.jpg
        String fileName = productImage.getId()+ ".jpg";
        //保存的不同文件夹地址
        String imageFolder;
        String imageFolder_small=null;
        String imageFolder_middle=null;
        //如果类型为type_single,则分类保存
        if(ProductImageService.type_single.equals(productImage.getType())){
            imageFolder= session.getServletContext().getRealPath("img/productSingle");
            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
        }
        else{
            //详细图片的存放地址
            imageFolder= session.getServletContext().getRealPath("img/productDetail");
        }

        //创建实际存放的文件实例
        File f = new File(imageFolder, fileName);
        //创建父目录
        if(!f.getParentFile().exists())
            f.getParentFile().mkdirs();
        //实际的文件存放操作
        try {
            image.transferTo(f);
            BufferedImage img = change2jpg(f);
            ImageIO.write(img, "jpg", f);

            if(ProductImageService.type_single.equals(productImage.getType())) {
                File f_small = new File(imageFolder_small, fileName);
                File f_middle = new File(imageFolder_middle, fileName);

                resizeImage(f, 56, 56, f_small);
                resizeImage(f, 217, 190, f_middle);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("保存成功");
        return "redirect:/admin/productImage?pid="+productImage.getPid();
    }

    @DeleteMapping(URL)
    @ResponseBody
    private Result delete(int id,HttpSession session){
        //获取具体的productImage实例
        ProductImage pi = productImageService.get(id);

        String fileName = pi.getId()+ ".jpg";
        String imageFolder;
        String imageFolder_small;
        String imageFolder_middle;

        //根据不同类型不同的删除操作
        if(ProductImageService.type_single.equals(pi.getType())){
            imageFolder= session.getServletContext().getRealPath("img/productSingle");
            imageFolder_small= session.getServletContext().getRealPath("img/productSingle_small");
            imageFolder_middle= session.getServletContext().getRealPath("img/productSingle_middle");
            File imageFile = new File(imageFolder,fileName);
            File f_small = new File(imageFolder_small,fileName);
            File f_middle = new File(imageFolder_middle,fileName);
            imageFile.delete();
            f_small.delete();
            f_middle.delete();

        }
        else{
            imageFolder= session.getServletContext().getRealPath("img/productDetail");
            File imageFile = new File(imageFolder,fileName);
            imageFile.delete();
        }

        //删除数据库中记录
        productImageService.delete(id);

        return new Result();
    }
}
























