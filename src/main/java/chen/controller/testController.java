package chen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

/**
 * tmallCopy
 * Create by chen on 17-11-1
 */
@Controller
public class testController {
    @RequestMapping("/test")
    private String hello(){
        return "admin/Test";
    }


    @PutMapping(value = "/puTest")
    private String test1(@RequestParam("id") int id){
        System.out.println(id);
        return "redirect:/test";
    }

    @PutMapping(value = "/upload")
    private String test(MultipartFile file){
        System.out.println("进入test方法");
        System.out.println(file.getOriginalFilename());
        return "redirect:/test";
    }

    public static void main(String[] args) {

        List<Integer> integers = Arrays.asList(1,2,3,4,5,6);
        integers.sort(new Comparator<Integer>() {
            @Override
            public int compare(Integer o1, Integer o2) {
                return o2-o1;
            }
        });
        System.out.println(integers);
    }
}
