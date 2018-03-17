package com.mwh.album.controller;

import com.mwh.album.common.CommonConstant;
import com.mwh.album.model.User;
import com.mwh.album.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController extends BaseController {

    private UserService userService;


    @RequestMapping(value="login",method=RequestMethod.GET)
    public ModelAndView userLogin(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/login.jsp");
        return mav;
    }

    /**
     * 用户登录
     * @param request
     * @param user
     * @return
     */
    @RequestMapping(value="login",method= RequestMethod.POST)
    public ModelAndView userLogin(HttpServletRequest request, User user){
        User dbUser = userService.findByUserName(user.getUserName());
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/login.jsp");
        if (dbUser == null) {
            mav.addObject("errorMsg", "用户不存在");
        } else if (!dbUser.getPassword().equals(user.getPassword())) {
            mav.addObject("errorMsg", "用户密码不正确");
        } else {
            user = dbUser;
            setSessionUser(request,dbUser);
            String toUrl = (String)request.getSession().getAttribute(CommonConstant.LOGIN_TO_URL);
            request.getSession().removeAttribute(CommonConstant.LOGIN_TO_URL);
            //如果当前会话中没有保存登录之前的请求URL，则直接跳转到主页
            if(StringUtils.isEmpty(toUrl)){
                toUrl = "user/home";
            }
            mav.setViewName(toUrl);
            mav.addObject(user);
        }
        return mav;
    }



    @RequestMapping(value="home")
    public ModelAndView home(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("user/home");
        return mav;
    }

    @Autowired
    public void setUserService(UserService userService){
        this.userService = userService;
    }
}
