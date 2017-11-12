package chen.controller;

import chen.service.ProductImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class ProductImageController {
    private final String URL = "/productImage";
    private final ProductImageService productImageService;

    @Autowired
    public ProductImageController(ProductImageService productImageService) {
        this.productImageService = productImageService;
    }

    @RequestMapping(URL)
    private String productImage(int pid, Model model){
        List productImages_single = productImageService.list(pid,ProductImageService.type_single);
        List productImages_detail = productImageService.list(pid,ProductImageService.type_detail);

        model.addAttribute("productImage_single",productImages_single);
        model.addAttribute("productImage_dateil",productImages_detail);
        return null;
    }
}
