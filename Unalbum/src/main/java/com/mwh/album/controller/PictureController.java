package com.mwh.album.controller;


import com.mwh.album.common.PageUtil;
import com.mwh.album.model.Picture;
import com.mwh.album.model.PictureCategory;
import com.mwh.album.model.User;
import com.mwh.album.service.PictureCategoryService;
import com.mwh.album.service.PictureService;

import com.sun.org.apache.xpath.internal.operations.Mod;
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
import java.util.*;

@Controller
@RequestMapping("picture")
public class PictureController extends BaseController {

    private PictureService pictureService;
    private PictureCategoryService pictureCategoryService;


    @RequestMapping(value = "category", method = RequestMethod.GET)
    public ModelAndView showCategoryPicture(HttpServletRequest request
            ,@RequestParam(value = "categoryId", required = false)String categoryId
            ,@RequestParam(value = "currIndex", required = false) String currIndex){
        ModelAndView mav = new ModelAndView();
        List<Picture> pictureList = pictureService
                .findByCategoryID(Integer.valueOf(categoryId));

        int pageIndex;
        int index = 0;
        int pageSize = 20;
        if(currIndex == null){
            currIndex = "";
        }
        if (currIndex.equals("")) {
            index = 0;
        } else if (!currIndex.equals("")) {
            pageIndex = Integer.parseInt(currIndex);
            index = (pageIndex - 1) * 20;
        }
        PageUtil<Picture> pageUtil = pictureService
                .findByCategoryIDOrderByPage(Integer.valueOf(categoryId), index, pageSize);
        mav.addObject("pageUtil", pageUtil);
        mav.addObject("categoryId", categoryId);
        mav.setViewName("picture/category");
        return mav;
    }

    @RequestMapping(value = "submit", method = RequestMethod.GET)
    public ModelAndView submit(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("user/submit");
        return mav;
    }

    @RequestMapping(value = "submit",method = RequestMethod.POST)
    public ModelAndView submit(HttpServletRequest request
        ,@RequestParam(value = "pictureCategory", required = false) String pictureCategory
        ,@RequestParam(value = "fileName", required = false) String fileName
        ,@RequestParam(value = "filePath", required = false) String filePath){
        ModelAndView mav = new ModelAndView();
        Picture picture = new Picture();
        User user = getSessionUser(request);
        int categoryId = pictureCategoryService
                .findByCategoryName(pictureCategory).getId();
        picture.setPicName(fileName);
        picture.setUser(user);
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
            if (!file2.exists()){
                file2.mkdirs();
            }
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
