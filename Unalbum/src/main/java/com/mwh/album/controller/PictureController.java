package com.mwh.album.controller;


import com.mwh.album.model.Picture;
import com.mwh.album.model.User;
import com.mwh.album.service.PictureCategoryService;
import com.mwh.album.service.PictureService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("picture")
public class PictureController extends BaseController {

    private PictureService pictureService;
    private PictureCategoryService pictureCategoryService;


    @RequestMapping(value="submit",method= RequestMethod.GET)
    public ModelAndView submit(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("user/submit");
        return mav;
    }

    @RequestMapping(value="submit",method= RequestMethod.POST)
    public ModelAndView submit(HttpServletRequest request
        ,@RequestParam(value = "pictureCategory", required = false) String pictureCategory
        ,@RequestParam(value = "fileName", required = false) String fileName
        ,@RequestParam(value = "filePath", required = false) String filePath){
        ModelAndView mav = new ModelAndView();
        Picture picture = new Picture();
        int userId = getSessionUser(request).getId();
        int categoryId = pictureCategoryService
                .findByCategoryName(pictureCategory).getId();
        picture.setPicName(fileName);
        picture.setUser(userId);
        picture.setPicCategory(categoryId);
        picture.setPicURL(filePath);
        picture.setPicLikes(0);
        picture.setPicCollection(0);
        picture.setCreateDate(new Date());
        pictureService.save(picture);
        mav.setViewName("user/submit");
        return mav;
    }

    @RequestMapping(value = "uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> uploadFile(@RequestParam(value = "file",required = false)MultipartFile file
            , HttpServletRequest request) {
        String pathRoot = request.getSession().getServletContext().getRealPath("");
        String path = "";
        User user = (User) getSessionUser(request);
        Map<String, String> uploadPicture = new HashMap();
        if (!file.isEmpty()) {
            //生成uuid作为文件名称，防止直接使用名字出现重复
            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            //获得文件类型 返回image/后缀
            String contentType = file.getContentType();
            //获得文件后缀名称
            String imageType = contentType.substring(contentType.indexOf("/") + 1);
            path = "picture/" + user.getUserName() + "/" + uuid + "." + imageType;
            File file2 = new File(pathRoot + path);
            //把图片存进指定目录；
            try {
                file.transferTo(file2);
                uploadPicture.put("fileName", uuid);
                uploadPicture.put("filePath", path);
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return uploadPicture;
    }


    @Autowired
    public void setPictureService(PictureService pictureService) {
        this.pictureService = pictureService;
    }

    @Autowired
    public void setPictureCategoryService(PictureCategoryService pictureCategoryService) {
        this.pictureCategoryService = pictureCategoryService;
    }
}
