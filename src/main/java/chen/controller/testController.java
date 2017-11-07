package chen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

    @RequestMapping(value = "/putTest",method = RequestMethod.PUT)
    private String test(int id){
        System.out.println("进入test犯法");
        System.out.println(id);
        return "redirect:/test";
    }
}
