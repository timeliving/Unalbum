package com.mwh.album.controller;

import com.mwh.album.model.Gallery;
import com.mwh.album.model.Picture;
import com.mwh.album.model.User;
import com.mwh.album.service.GalleryPictureService;
import com.mwh.album.service.GalleryService;
import com.mwh.album.service.PictureService;
import com.mwh.album.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping(value = "gallery")
public class GalleryController extends BaseController {

    private GalleryService galleryService;
    private GalleryPictureService galleryPictureService;
    private UserService userService;
    private PictureService pictureService;

    @RequestMapping(value = "picturesByGalleryId",method = RequestMethod.GET)
    public ModelAndView picturesByGalleryId(@RequestParam(value = "galleryId") Integer galleryId
            ,@RequestParam(value = "userId") Integer userId
            , HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        User user = userService.findById(userId);
        List<Picture> galleryPictureList = galleryPictureService
                .findPicturesByGalleryId(galleryId);

        List<Picture> pictureByUserList = pictureService.findByUserId(userId, 0, 10);
        Gallery gallery = galleryService.findById(galleryId);
        mav.addObject("user", user);
        mav.addObject("galleryPictureList", galleryPictureList);
        mav.addObject("gallery", gallery);

        mav.setViewName("/picture/galleryPictures");
        return mav;
    }


    @RequestMapping(value = "userGalleryHome",method = RequestMethod.GET)
    public ModelAndView userGalleryHome(@RequestParam(value = "id") String id
            , HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        int userId = 0;
        User user = new User();
        if(id != null){
            userId = Integer.valueOf(id);
            user = userService.findById(userId);
        }else{
            userId = getSessionUser(request).getId();
            user = getSessionUser(request);
        }
        List<Gallery> galleryList = galleryService.findByUserId(userId);

        List<Picture> pictureByUserList = pictureService.findByUserId(userId, 0, 10);
        Picture picture = pictureByUserList.get(new Random().nextInt(10));
        mav.addObject("user", user);
        mav.addObject("galleryList", galleryList);
        mav.addObject("picture", picture);
        mav.setViewName("/picture/gallery");
        return mav;
    }


    @RequestMapping(value = "pictures",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> galleryPictures(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, Object> reply = new HashMap<String, Object>();
        int userId = Integer.parseInt(map.get("userId").toString());
        int galleryId = Integer.parseInt(map.get("galleryId").toString());
        List<Picture> galleryPictureList = galleryPictureService
                .findPicturesByGalleryId(galleryId);
        reply.put("galleryPictureList", galleryPictureList);
        reply.put("galleryId", galleryId);
        return reply;
    }



    @Autowired
    public void setGalleryService(GalleryService galleryService) {
        this.galleryService = galleryService;
    }

    @Autowired
    public void setGalleryPictureService(GalleryPictureService galleryPictureService) {
        this.galleryPictureService = galleryPictureService;
    }

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired
    public void setPictureService(PictureService pictureService) {
        this.pictureService = pictureService;
    }
}
