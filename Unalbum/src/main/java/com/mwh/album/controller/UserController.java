package com.mwh.album.controller;

import com.mwh.album.common.CommonConstant;
import com.mwh.album.common.PageUtil;
import com.mwh.album.model.*;
import com.mwh.album.service.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("user")
public class UserController extends BaseController {

    private UserService userService;
    private PictureService pictureService;
    private PictureCategoryService pictureCategoryService;
    private PictureTagService pictureTagService;
    private UserLikeCollectionService userLikeCollectionService;
    private TagService tagService;


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

    @RequestMapping(value = "pictures",method = RequestMethod.GET)
    public ModelAndView userPictures(@Param(value = "code") String code
            , HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        if(code == null){
            code = "个人相片管理";
        }

        mav.setViewName("/user/pictures");

        mav.addObject("code",code);

        return mav;
    }

    @RequestMapping(value = "picturesByUser",method = RequestMethod.GET)
    public ModelAndView userPicturesByUser(HttpServletRequest request
            ,@RequestParam(value = "currIndex", required = false) String currIndex){
        ModelAndView mav = new ModelAndView();
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        User user = getSessionUser(request);
        int pageIndex;
        int index = 0;
        int pageSize = 10;
        if(currIndex == null){
            currIndex = "";
        }
        if (currIndex.equals("")) {
            index = 0;
        } else if (!currIndex.equals("")) {
            pageIndex = Integer.parseInt(currIndex);
            index = (pageIndex - 1) * 10;
        }
        List<Picture> pictureList = new ArrayList<Picture>();
        if(user.getId() != null){
            pageUtil = pictureService.findByUserIdOrderByPage(user.getId(), index, pageSize);
            pictureList = pictureService.findByUserId(user.getId(), index, pageSize);
        }
        mav.addObject("pageUtil", pageUtil);
        List<PictureCategory> pictureCategoryList = pictureCategoryService.findAll();
        List<String> myPictureCategoryList = new ArrayList<String>();
        for(Picture picture : pictureList){
            if(picture.getPicCategory() != null){
                for(PictureCategory pictureCategory : pictureCategoryList){
                    if(picture.getPicCategory().equals(pictureCategory.getId())){
                        myPictureCategoryList.add(pictureCategory.getCategoryName());
                    }
                }
            }
        }
        mav.addObject("myPictureCategoryList", myPictureCategoryList);
        mav.setViewName("/user/picturesUser");
        return mav;
    }

    @RequestMapping(value = "picturesByUserAndDate")
    public ModelAndView userPicturesByUserAndDate(HttpServletRequest request
            ,@RequestParam(value = "beginDate", required = false) String beginDate
            ,@RequestParam(value = "endDate", required = false) String endDate
            ,@RequestParam(value = "currIndex", required = false) String currIndex){
        ModelAndView mav = new ModelAndView();
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        User user = getSessionUser(request);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date begin = null;
        Date end = null;
        try {
            if(!"".equals(beginDate)){
                begin = format.parse(beginDate);
            }
            if(!"".equals(endDate)){
                end = format.parse(endDate);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        int pageIndex;
        int index = 0;
        int pageSize = 10;
        if(currIndex == null){
            currIndex = "";
        }
        if (currIndex.equals("")) {
            index = 0;
        } else if (!currIndex.equals("")) {
            pageIndex = Integer.parseInt(currIndex);
            index = (pageIndex - 1) * 10;
        }
        List<Picture> pictureList = new ArrayList<Picture>();
        if(user.getId() != null){
            pageUtil = pictureService.findByUserIdOrderByPageAndDate(user.getId(), index, pageSize, begin, end);
            pictureList = pictureService.findByUserId(user.getId(), index, pageSize);
        }
        mav.addObject("pageUtil", pageUtil);
        List<PictureCategory> pictureCategoryList = pictureCategoryService.findAll();
        List<String> myPictureCategoryList = new ArrayList<String>();
        for(Picture picture : pictureList){
            if(picture.getPicCategory() != null){
                for(PictureCategory pictureCategory : pictureCategoryList){
                    if(picture.getPicCategory().equals(pictureCategory.getId())){
                        myPictureCategoryList.add(pictureCategory.getCategoryName());
                    }
                }
            }
        }
        mav.addObject("myPictureCategoryList", myPictureCategoryList);
        mav.addObject("beginDate", beginDate);
        mav.addObject("endDate", endDate);
        mav.setViewName("/user/picturesUserByDate");
        return mav;
    }

    @RequestMapping(value = "picture/edit",method = RequestMethod.GET)
    public ModelAndView userPictureEdit(@RequestParam(value = "pictureId") String pictureId
            , HttpServletRequest request){
        ModelAndView mav = new ModelAndView();

        Picture picture = pictureService.findById(Integer.parseInt(pictureId));
        if(picture.getId() != null){
            mav.addObject("picture", picture);
        }
        List<PictureTag> pictureTagList = pictureTagService
                .findByPictureId(Integer.parseInt(pictureId));
        List<Tag> tagList = new ArrayList<Tag>();
        if(!pictureTagList.isEmpty()){
            for(PictureTag pictureTag : pictureTagList){
                tagList.add(tagService.findById(pictureTag.getTagId()));
            }
        }
        List<PictureCategory> pictureCategoryList = pictureCategoryService.findAll();
        StringBuilder tags = new StringBuilder();
        for(Tag tag : tagList){
            tags.append(tag.getTagName() + " ");
        }
        mav.addObject("tags", tags.toString());
        mav.addObject("pictureCategoryList", pictureCategoryList);
        mav.setViewName("/user/pictureEdit");
        return mav;
    }


    @RequestMapping(value = "picture/edit",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> userPictureEdit(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        String picName = map.get("picName").toString();
        Integer picCategory = Integer.valueOf(map.get("picCategory").toString());
        String tags = map.get("tags").toString();
        String picProfile = map.get("picProfile").toString();
        if(picProfile == null){
            picProfile = "";
        }
        String[] tagList = tags.split(" ");
        for(String tag : tagList){
            Tag t = tagService.findByTagNameNoBlur(tag);
            if(t.getId() != null){
                PictureTag pictureTag = new PictureTag();
                pictureTag.setPictureId(pictureId);
                pictureTag.setTagId(t.getId());
                pictureTagService.save(pictureTag);
            }else{
                t.setTagName(tag);
                t.setUser(getSessionUser(request));
                int tagId = tagService.save(t);
                PictureTag pictureTag = pictureTagService.findByTagIdAndPictureId(tagId, pictureId);
                if(pictureTag.getId() == null){
                    pictureTag.setTagId(tagId);
                    pictureTag.setPictureId(pictureId);
                    pictureTagService.save(pictureTag);
                }
            }
        }
        Picture picture = new Picture();
        picture.setId(pictureId);
        picture.setPicName(picName);
        picture.setPicCategory(picCategory);
        picture.setPicProfile(picProfile);
        pictureService.update(picture);
        reply.put("success", "成功");
        return reply;
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
        User user = getSessionUser(request);
        user.setPhoto(img);
        userService.uploadProfile(Integer.parseInt(id), img);
        mav.setViewName("/user/profile");
        return mav;
    }

    @RequestMapping(value = "/picture/unShare", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> pictureUnShare(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        Picture picture = pictureService.findById(pictureId);
        if(picture.getId() != null){
            picture.setIsShare(0);
        }
        pictureService.update(picture);
        reply.put("success", "成功");
        reply.put("pictureId", map.get("pictureId").toString());
        return reply;
    }

    @RequestMapping(value = "/picture/share", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> pictureShare(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        Picture picture = pictureService.findById(pictureId);
        if(picture.getId() != null){
            picture.setIsShare(1);
        }
        pictureService.update(picture);
        reply.put("success", "成功");
        reply.put("pictureId", map.get("pictureId").toString());
        return reply;
    }

    @RequestMapping(value = "/picture/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> pictureDelete(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, String> reply = new HashMap<String, String>();
        Integer pictureId = Integer.valueOf(map.get("pictureId").toString());
        Picture picture = pictureService.findById(pictureId);
        pictureService.delete(pictureId);
        pictureTagService.deleteByPictureId(pictureId);
        userLikeCollectionService.deleteByPictureId(pictureId);
        reply.put("success", "成功");
        reply.put("pictureId", map.get("pictureId").toString());
        return reply;
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
        return path;
    }

    @Autowired
    public void setUserService(UserService userService){
        this.userService = userService;
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
    public void setPictureTagService(PictureTagService pictureTagService) {
        this.pictureTagService = pictureTagService;
    }

    @Autowired
    public void setUserLikeCollectionService(UserLikeCollectionService userLikeCollectionService) {
        this.userLikeCollectionService = userLikeCollectionService;
    }

    @Autowired
    public void setTagService(TagService tagService) {
        this.tagService = tagService;
    }
}
