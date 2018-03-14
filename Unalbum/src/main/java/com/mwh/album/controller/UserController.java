package com.mwh.album.controller;

import com.mwh.album.model.User;
import com.mwh.album.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {

    private UserService userService;


    @RequestMapping("userInfo.html")
    public ModelAndView userInfo(HttpServletRequest request){

        User user = getSessionUser(request);
        ModelAndView mav = new ModelAndView();

        if(user==null){
            mav.setViewName("redirect:/login.jsp");
        }else{
            mav.addObject("user", user);

            mav.setViewName("userInfo");

        }
        return mav;

    }

    @Autowired
    public void setUserService(UserService userService){
        this.userService = userService;
    }

}
