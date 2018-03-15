package com.mwh.album.controller;

import com.mwh.album.common.CommonConstant;
import com.mwh.album.model.User;
import com.mwh.album.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {

    private UserService userService;


    @RequestMapping(value = "account",method = RequestMethod.GET)
    public ModelAndView userAccount(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        User user = (User)request.getSession().getAttribute(CommonConstant.USER_CONTEXT);
        mav.setViewName("/user/account");
        mav.addObject(user);
        return mav;
    }

    @RequestMapping(value = "account",method = RequestMethod.POST)
    public ModelAndView userAccount(HttpServletRequest request, User user){
        ModelAndView mav = new ModelAndView();
        userService.updateProfile(user);
        mav.setViewName("/user/account");
        return mav;
    }

    @RequestMapping(value = "account/password",method = RequestMethod.GET)
    public ModelAndView userPassword(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("/user/password");
        return mav;
    }

    @RequestMapping(value = "account/password",method = RequestMethod.POST)
    public ModelAndView userPassword(HttpServletRequest request
            ,@RequestParam(value = "id", required = false) String id
            ,@RequestParam(value = "password", required = false) String password){
        ModelAndView mav = new ModelAndView();
        userService.updatePassword(Integer.parseInt(id),password);
        mav.setViewName("/user/password");
        return mav;
    }

    @RequestMapping(value = "account/profile",method = RequestMethod.GET)
    public ModelAndView userProfile(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();

        mav.setViewName("/user/profile");
        return mav;
    }

    @RequestMapping(value = "account/profile",method = RequestMethod.POST)
    public ModelAndView userProfile(HttpServletRequest request
            ,@RequestParam(value = "id", required = false) String id
            ,@RequestParam(value = "file", required = false) MultipartFile file
            ){
        ModelAndView mav = new ModelAndView();
        String img = fileToImg(file, request);
        //String img = "personIcon/";
        User user = getSessionUser(request);
        user.setPhoto(img);
        userService.uploadProfile(Integer.parseInt(id), img);
        mav.setViewName("/user/profile");
        return mav;
    }

    public String fileToImg(MultipartFile file, HttpServletRequest request) {
        // TODO Auto-generated method stub
        /* 1， 使用spring的MultipartFile获取jsp传过来的文件；
         * 2， 设置需要存放文件的路径，文件名字，与后缀；
         * 3， file.transferTo(路径);
         *
         * */
        //获得物理路径webapp所在路径
        String pathRoot = request.getSession().getServletContext().getRealPath("");
        String path="";
        if(!file.isEmpty()){
            //生成uuid作为文件名称，防止直接使用名字出现重复
            String uuid = UUID.randomUUID().toString().replaceAll("-","");
            //获得文件类型 返回image/后缀
            String contentType=file.getContentType();
            System.out.println(contentType);
            //获得文件后缀名称
            String imageName=contentType.substring(contentType.indexOf("/")+1);
            //String localpath="D:"+File.separator+"imagies"+File.separator+uuid+"."+imageName;
            path="personIcon/"+uuid+"."+imageName;
            File file2=new File(pathRoot+path);
            //把图片存进指定目录；
            try {
                file.transferTo(file2);
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        System.out.println(path);
        return path;
    }

    @Autowired
    public void setUserService(UserService userService){
        this.userService = userService;
    }


}
