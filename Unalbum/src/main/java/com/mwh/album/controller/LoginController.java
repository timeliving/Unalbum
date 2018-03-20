package com.mwh.album.controller;

import com.mwh.album.common.CommonConstant;
import com.mwh.album.model.Picture;
import com.mwh.album.model.PictureCategory;
import com.mwh.album.model.User;
import com.mwh.album.service.PictureCategoryService;
import com.mwh.album.service.PictureService;
import com.mwh.album.service.UserService;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class LoginController extends BaseController {

    private UserService userService;
    private PictureCategoryService pictureCategoryService;
    private PictureService pictureService;

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
                toUrl = "forward:/home";
            }
            mav.setViewName(toUrl);
            mav.addObject(user);
        }
        return mav;
    }



    @RequestMapping(value="home")
    public ModelAndView home(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();

        List<PictureCategory> pictureCategoryList = new ArrayList<PictureCategory>();
        pictureCategoryList = pictureCategoryService.findAll();
        List<String> userInterests = new ArrayList<String>();
        //List<String> interests = new ArrayList<String>();
        if(getSessionUser(request) == null){
            for (PictureCategory pictureCategory : pictureCategoryList){
                userInterests.add(pictureCategory.getCategoryName());
            }
        }else{
            userInterests = userService
                    .findUserInterests(getSessionUser(request).getId());

            if(userInterests != null){
                //CollectionUtils.addAll(userInterests, new String[interests.size()]);
                //Collections.copy(userInterests, interests);
                for(PictureCategory pictureCategory : pictureCategoryList){
                    if(!userInterests.contains(pictureCategory.getCategoryName())){
                        userInterests.add(pictureCategory.getCategoryName());
                    }
                }
                for (String userInterest : userInterests){

                }
            }else{
                for (PictureCategory pictureCategory : pictureCategoryList){
                    userInterests.add(pictureCategory.getCategoryName());
                }
            }
        }
        List<Map<String,String>> categoryList = new ArrayList<Map<String, String>>();
        for(String interest : userInterests){
            Picture picture = pictureService.findByDateMostClose(interest);
            String picURL = picture.getPicURL();
            Map<String, String> categoryMap = new HashMap<String, String>();
            categoryMap.put("categoryName", interest);
            categoryMap.put("picURL", picURL);
            Integer categoryId = pictureCategoryService
                    .findByCategoryName(interest).getId();
            categoryMap.put("categoryId", categoryId.toString());
            categoryList.add(categoryMap);
        }
        mav.addObject("categoryList", categoryList);

        List<Picture> dayPictures = new ArrayList<Picture>();
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.DAY_OF_MONTH, -1);// 今天-1天
        Date yesterday = c.getTime();
        dayPictures = pictureService.findByPictureLikes(yesterday);
        mav.addObject("dayPictures", dayPictures);
        mav.setViewName("picture/home");
        return mav;
    }

    @Autowired
    public void setUserService(UserService userService){
        this.userService = userService;
    }

    @Autowired
    public void setPictureCategoryService(PictureCategoryService pictureCategoryService) {
        this.pictureCategoryService = pictureCategoryService;
    }

    @Autowired
    public void setPictureService(PictureService pictureService) {
        this.pictureService = pictureService;
    }
}
