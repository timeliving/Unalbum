package com.mwh.album.controller;

import com.mwh.album.common.IsIn;
import com.mwh.album.model.Gallery;
import com.mwh.album.model.GalleryPicture;
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
    public ModelAndView picturesByGalleryId(@RequestParam(value = "galleryId", required = false) Integer galleryId
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

    @RequestMapping(value = "picturesByUserGalleryId",method = RequestMethod.GET)
    public ModelAndView picturesByUserGalleryId(@RequestParam(value = "galleryId", required = false) Integer galleryId
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

        mav.setViewName("/user/picturesByGallery");
        return mav;
    }


    @RequestMapping(value = "userGalleryHome",method = RequestMethod.GET)
    public ModelAndView userGalleryHome(@RequestParam(value = "id", required = false) String id
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

    @RequestMapping(value = "add",method = RequestMethod.GET)
    public ModelAndView userGalleryAdd(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/user/galleryAdd");
        return mav;
    }

    @RequestMapping(value = "add",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> userGalleryAdd(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        String galleryName = map.get("galleryName").toString();

        Gallery gallery = new Gallery();
        gallery.setGalleryName(galleryName);
        gallery.setUser(getSessionUser(request));

        galleryService.save(gallery);
        reply.put("success", "成功");
        return reply;
    }

    @RequestMapping(value = "addPicture",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> galleryAddPicture(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, Object> reply = new HashMap<String, Object>();
        int pictureId = Integer.parseInt(map.get("pictureId").toString());
        int galleryId = Integer.parseInt(map.get("galleryId").toString());

        Gallery gallery = galleryService.findById(galleryId);
        GalleryPicture galleryPicture = new GalleryPicture();
        galleryPicture.setGallery(gallery);
        galleryPicture.setPictureId(pictureId);
        galleryPictureService.save(galleryPicture);
        galleryService.updateGalleryPagePicture(pictureId, gallery.getId());
        String inGallery = "inGallery-" + galleryId;
        String galleryDiv = "gallery-" + galleryId;
        reply.put("inGallery", inGallery);
        reply.put("gallery", galleryDiv);
        reply.put("success", "成功");
        return reply;
    }

    @RequestMapping(value = "edit",method = RequestMethod.GET)
    public ModelAndView userGalleryEdit(@RequestParam(value = "galleryId", required = false) Integer galleryId
            , HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        Gallery gallery = galleryService.findById(galleryId);

        mav.addObject("gallery", gallery);
        mav.setViewName("/user/galleryEdit");
        return mav;
    }

    @RequestMapping(value = "edit",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> userGalleryEdit(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer galleryId = Integer.valueOf(map.get("galleryId").toString());
        String galleryName = map.get("galleryName").toString();
        Gallery gallery = galleryService.findById(galleryId);
        gallery.setGalleryName(galleryName);
        galleryService.update(gallery);
        reply.put("success", "成功");
        return reply;
    }



    @RequestMapping(value = "getGalleryList", method = RequestMethod.GET)
    public ModelAndView getGalleryList(@RequestParam(value = "id") String id
            , HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        int pictureId = Integer.parseInt(id);
        User user = getSessionUser(request);
        Picture pic = pictureService.findById(pictureId);
        List<Gallery> galleryListByUser = galleryService.findUserGalleryWithOutDefault(user.getId());
        List<String> pictureOfGalleryList = new ArrayList<String>();
        for(Gallery gallery : galleryListByUser){
            int listSize = pictureOfGalleryList.size();
            List<Integer> galleryPictures = galleryPictureService.findPictureIdByGalleryId(gallery.getId());
            if(!galleryPictures.isEmpty()){
                for(Integer idPicture : galleryPictures){
                    if(idPicture == pictureId){
                        pictureOfGalleryList.add("in");
                    }
                }
                if(pictureOfGalleryList.size() == listSize){
                    pictureOfGalleryList.add("notIn");
                }
            }
        }
        mav.addObject("galleryListByUser", galleryListByUser);
        mav.addObject("pictureOfGalleryList",pictureOfGalleryList);
        mav.addObject("picture",pic);
        mav.setViewName("/picture/galleryAddPicture");
        return mav;
    }

    @RequestMapping(value = "galleryByUser", method = RequestMethod.GET)
    public ModelAndView galleryByUser(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        User user = getSessionUser(request);
        List<Gallery> galleryListByUser = galleryService.findByUserId(user.getId());

        mav.addObject("galleryListByUser", galleryListByUser);

        mav.setViewName("/user/galleryUser");
        return mav;
    }

    @RequestMapping(value = "unShare", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> galleryUnShare(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer galleryId = Integer.valueOf(map.get("galleryId").toString());
        Gallery gallery = galleryService.findById(galleryId);
        String input_unShare_id = map.get("input_unShare_id").toString();
        if(gallery.getId() != null){
            gallery.setIsShare(0);
        }
        galleryService.update(gallery);
        reply.put("success", "成功");
        reply.put("galleryId", map.get("galleryId").toString());
        reply.put("input_unShare_id",input_unShare_id);
        return reply;
    }

    @RequestMapping(value = "share", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> galleryShare(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer galleryId = Integer.valueOf(map.get("galleryId").toString());
        Gallery gallery = galleryService.findById(galleryId);
        String input_share_id = map.get("input_share_id").toString();
        if(gallery.getId() != null){
            gallery.setIsShare(1);
        }
        galleryService.update(gallery);
        reply.put("success", "成功");
        reply.put("galleryId", map.get("galleryId").toString());
        reply.put("input_share_id", input_share_id);
        return reply;
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> galleryDelete(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer galleryId = Integer.valueOf(map.get("galleryId").toString());
        pictureService.delete(galleryId);
        galleryPictureService.deleteByGalleryId(galleryId);
        reply.put("success", "成功");
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
