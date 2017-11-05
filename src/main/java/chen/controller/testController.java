package chen.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * tmallCopy
 * Create by chen on 17-11-1
 */
@Controller
public class testController {
    @RequestMapping("test")
    private String hello(){
        return "public/adminNavigator";
    }
}
