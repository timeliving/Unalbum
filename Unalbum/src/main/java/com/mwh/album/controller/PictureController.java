package com.mwh.album.controller;


import com.mwh.album.common.PageUtil;
import com.mwh.album.model.*;
import com.mwh.album.service.*;

import net.coobird.thumbnailator.Thumbnails;
import org.opencv.core.Mat;
import org.opencv.core.Size;
import org.opencv.imgcodecs.Imgcodecs;
import org.opencv.imgproc.Imgproc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("picture")
public class
PictureController extends BaseController {

    private PictureService pictureService;
    private PictureCategoryService pictureCategoryService;
    private UserLikeCollectionService userLikeCollectionService;
    private GalleryPictureService galleryPictureService;
    private GalleryService galleryService;

    @RequestMapping(value = "category", method = RequestMethod.GET)
    public ModelAndView showCategoryPicture(HttpServletRequest request
            ,@RequestParam(value = "categoryId", required = false)String categoryId
            ,@RequestParam(value = "currIndex", required = false) String currIndex){
        ModelAndView mav = new ModelAndView();
        User user = getSessionUser(request);
        int pageIndex;
        int index = 0;
        int pageSize = 15;
        if(currIndex == null){
            currIndex = "";
        }
        if (currIndex.equals("")) {
            index = 0;
        } else if (!currIndex.equals("")) {
            pageIndex = Integer.parseInt(currIndex);
            index = (pageIndex - 1) * 15;
        }
        if(user.getId() != null){
            PageUtil<Map<Object, Object>> pageUtil =new PageUtil<Map<Object, Object>>();
            pageUtil = pictureService
                    .findByCategoryIDOrderByPageWithUserId(Integer.valueOf(categoryId)
                            , user.getId(), index, pageSize);
            mav.addObject("pageUtil", pageUtil);
        }else{
            PageUtil<Picture> pageUtil =new PageUtil<Picture>();
            pageUtil = pictureService
                    .findByCategoryIDOrderByPage(Integer.valueOf(categoryId)
                            , index, pageSize);
            mav.addObject("pageUtil", pageUtil);
        }
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
        ,@RequestParam(value = "fileName", required = false) String fileName
        ,@RequestParam(value = "filePath", required = false) String filePath){
        ModelAndView mav = new ModelAndView();
        Picture picture = new Picture();
        User user = getSessionUser(request);
        picture.setPicName(fileName);
        picture.setUser(user);
        picture.setPicCategory(0);
        picture.setPicURL(filePath);
        picture.setPicLikes(0);
        picture.setPicCollection(0);
        picture.setCreateDate(new Date());
        picture.setPicProfile("");
        picture.setIsShare(1);
        int id = pictureService.save(picture);
        GalleryPicture galleryPicture = new GalleryPicture();
        Gallery gallery = galleryService.findUserGallery(user.getId(), "默认相册");
        if(gallery.getId() != null){
            galleryPicture.setGallery(gallery);
        }
        galleryPicture.setPictureId(id);
        galleryPicture.setCreateDate(new Date());
        galleryPictureService.save(galleryPicture);
        galleryService.updateGalleryPagePicture(id, gallery.getId());
        mav.setViewName("user/submit");
        return mav;
    }



    @RequestMapping(value = "uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> uploadFile(@RequestParam(value = "file",required = false)MultipartFile file
            , HttpServletRequest request) {
        String pathRoot = request.getSession().getServletContext().getRealPath("");
        String path = "";
        User user = getSessionUser(request);
        Map<String, String> uploadPicture = new HashMap();
        if (file !=null && !file.isEmpty()) {
            //生成uuid作为文件名称，防止直接使用名字出现重复
            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            //获得文件类型 返回image/后缀
            String contentType = file.getContentType();
            String fileName = file.getOriginalFilename();
            //获得文件后缀名称
            fileName = fileName.substring(0, fileName.indexOf("."));
            String imageType = contentType.substring(contentType.indexOf("/") + 1);
            path = "picture/" + user.getUserName() + "/" + uuid + "." + imageType;
            File file2 = new File(pathRoot + path);
            if (!file2.exists()){
                file2.mkdirs();
            }
            //把图片存进指定目录；
            try {
                file.transferTo(file2);
                uploadPicture.put("fileName", fileName);
                uploadPicture.put("filePath", path);
            } catch (IllegalStateException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return uploadPicture;
    }

    @RequestMapping(value = "saveLike", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> saveLike(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        Integer userId = Integer.valueOf(map.get("userId").toString());
        Picture picture = pictureService.findById(pictureId);
        UserLikeCollection userLikeCollection = userLikeCollectionService
                .findByUserIdAndPictureId(userId, pictureId);
        if(userLikeCollection.getId() == null){
            userLikeCollection = new UserLikeCollection();
            picture.setPicLikes(picture.getPicLikes() + 1);
            pictureService.updatePictureLikes(picture);
            userLikeCollection.setIsCollection(0);
            userLikeCollection.setIsLike(1);
            userLikeCollection.setUser(getSessionUser(request));
            userLikeCollection.setCreateDate(new Date());
            userLikeCollection.setPicture(picture);
        }else{
            userLikeCollection.setIsLike(1);
            userLikeCollection.setUser(getSessionUser(request));
            userLikeCollection.setPicture(picture);
        }
        userLikeCollectionService.save(userLikeCollection);
        reply.put("success", "成功");
        reply.put("div_like_id", map.get("div_like_id").toString());
        reply.put("div_unlike_id", map.get("div_unlike_id").toString());
        return reply;
    }

    @RequestMapping(value = "deleteLike", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> deleteLike(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        Integer userId = Integer.valueOf(map.get("userId").toString());
        Picture picture = pictureService.findById(pictureId);
        picture.setPicLikes(picture.getPicLikes() - 1);
        pictureService.updatePictureLikes(picture);
        UserLikeCollection userLikeCollection = userLikeCollectionService
                .findByUserIdAndPictureId(userId, pictureId);
        userLikeCollection.setIsLike(0);
        userLikeCollection.setUser(getSessionUser(request));
        userLikeCollection.setPicture(picture);
        userLikeCollectionService.update(userLikeCollection);
        reply.put("success", "成功");
        reply.put("div_like_id", map.get("div_like_id").toString());
        reply.put("div_unlike_id", map.get("div_unlike_id").toString());
        return reply;
    }

    @RequestMapping(value = "saveCollection", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> saveCollection(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        Integer userId = Integer.valueOf(map.get("userId").toString());
        Picture picture = pictureService.findById(pictureId);
        UserLikeCollection userLikeCollection = userLikeCollectionService
                .findByUserIdAndPictureId(userId, pictureId);
        if(userLikeCollection.getId() == null){
            picture.setPicCollection(picture.getPicCollection() + 1);
            pictureService.updatePictureCollection(picture);
            userLikeCollection.setUser(getSessionUser(request));
            userLikeCollection.setIsCollection(1);
            userLikeCollection.setIsLike(0);
            userLikeCollection.setCreateDate(new Date());
            userLikeCollection.setPicture(picture);
        }else{
            userLikeCollection.setIsCollection(1);
            userLikeCollection.setUser(getSessionUser(request));
            userLikeCollection.setPicture(picture);
        }
        userLikeCollectionService.save(userLikeCollection);
        GalleryPicture galleryPicture = new GalleryPicture();
        galleryPicture.setPictureId(pictureId);
        Gallery gallery =galleryService.findUserGallery(userId, "ta的收藏");
        galleryPicture.setGallery(gallery);
        galleryPictureService.save(galleryPicture);
        galleryService.updateGalleryPagePicture(pictureId, gallery.getId());
        reply.put("success", "成功");
        reply.put("div_collection_id", map.get("div_collection_id").toString());
        reply.put("div_uncollection_id", map.get("div_uncollection_id").toString());
        return reply;
    }

    @RequestMapping(value = "deleteCollection", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> deleteCollection(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        Integer userId = Integer.valueOf(map.get("userId").toString());
        Picture picture = pictureService.findById(pictureId);
        picture.setPicCollection(picture.getPicCollection() - 1);
        pictureService.updatePictureCollection(picture);
        UserLikeCollection userLikeCollection = userLikeCollectionService
                .findByUserIdAndPictureId(userId, pictureId);
        userLikeCollection.setIsCollection(0);
        userLikeCollection.setUser(getSessionUser(request));
        userLikeCollection.setPicture(picture);
        userLikeCollectionService.save(userLikeCollection);

        int galleryId = galleryService.findUserGallery(userId
                , "ta的收藏").getId();
        galleryPictureService.deleteByGalleryIdAndPictureId(galleryId, pictureId);
        GalleryPicture galleryPicture = galleryPictureService.findMostColsePicture(galleryId);
        galleryService.updateGalleryPagePicture(galleryPicture.getPictureId(), galleryId);
        reply.put("success", "成功");
        reply.put("div_collection_id", map.get("div_collection_id").toString());
        reply.put("div_uncollection_id", map.get("div_uncollection_id").toString());
        return reply;
    }


    @Autowired
    public void setPictureService(PictureService pictureService) {
        this.pictureService = pictureService;
    }

    @Autowired
    public void setPictureCategoryService(PictureCategoryService pictureCategoryService) {
        this.pictureCategoryService = pictureCategoryService;
    }

    @Autowired
    public void setUserLikeCollectionService(UserLikeCollectionService userLikeCollectionService) {
        this.userLikeCollectionService = userLikeCollectionService;
    }

    @Autowired
    public void setGalleryPictureService(GalleryPictureService galleryPictureService) {
        this.galleryPictureService = galleryPictureService;
    }

    @Autowired
    public void setGalleryService(GalleryService galleryService) {
        this.galleryService = galleryService;
    }
}
