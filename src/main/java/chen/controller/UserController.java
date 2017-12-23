package chen.controller;

import chen.dto.Result;
import chen.entity.User;
import chen.service.UserService;
import chen.util.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller()
@RequestMapping("/admin")
public class UserController {
    private final static String URL = "/user";
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping(URL)
    private String list(Model model, Page page){
        //PageHelper设置
        PageHelper.offsetPage(page.getStart(),page.getCount());
        //获取UserList
        List<User> userList = userService.list();
        //page设置
        page.setTotal((int)new PageInfo(userList).getTotal());
        model.addAttribute("userList",userList);
        model.addAttribute("page",page);
        return "admin/User";
    }

    @PostMapping("/add")
    @ResponseBody
    private Result add(User user){
        userService.add(user);
        return new Result();
    }

}
