package com.mwh.album.controller;

import com.mwh.album.common.PageUtil;
import com.mwh.album.model.Picture;
import com.mwh.album.model.PictureTag;
import com.mwh.album.model.Tag;
import com.mwh.album.model.User;
import com.mwh.album.service.PictureService;
import com.mwh.album.service.PictureTagService;
import com.mwh.album.service.TagService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * @author mwh
 */
@Controller
@RequestMapping("search")
public class PictureTagController extends BaseController {

    private PictureTagService pictureTagService;
    private PictureService pictureService;
    private TagService tagService;

    @RequestMapping(value = "pictureTag", method = RequestMethod.GET)
    public ModelAndView pictureTag(@RequestParam(value = "keyword") String keyword
            ,@RequestParam(value = "currIndex", required = false) String currIndex
            , HttpServletRequest request){
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
        //region IF keyword is ""
        if("".equals(keyword)){
            if(user.getId() != null){
                PageUtil<Map<Object, Object>> pageUtil =new PageUtil<Map<Object, Object>>();
                pageUtil = pictureService
                        .findAllByPageWithUserId(user.getId(), index, pageSize);
                mav.addObject("pageUtil", pageUtil);
            }else{
                PageUtil<Picture> pageUtil =new PageUtil<Picture>();
                pageUtil = pictureService
                        .findAllByPage(index, pageSize);
                mav.addObject("pageUtil", pageUtil);
            }
        }//endregion
        else{
            if(user.getId() != null){
                PageUtil<Map<Object, Object>> pageUtil =new PageUtil<Map<Object, Object>>();
                pageUtil = pictureService
                        .findAllByTagAndPageWithUserId(keyword
                                , user.getId(), index, pageSize);

                if(pageUtil.getCount() == 0){
                    mav.addObject("errorMsg","No");
                    mav.addObject("keyword" ,keyword);
                }else{
                    mav.addObject("errorMsg" ,"yes");
                    mav.addObject("keyword" ,keyword);
                }
                mav.addObject("pageUtil", pageUtil);
            }else{
                PageUtil<Picture> pageUtil =new PageUtil<Picture>();
                pageUtil = pictureService
                        .findAllByTagAndPage(keyword
                                , index, pageSize);
                if(pageUtil.getCount() == 0){
                    mav.addObject("errorMsg","No");
                    mav.addObject("keyword" ,keyword);
                }else{
                    mav.addObject("keyword" ,"yes");
                    mav.addObject("keyword" ,keyword);
                }
                mav.addObject("pageUtil", pageUtil);
            }
        }

        mav.addObject("keyword", keyword);
        mav.setViewName("search/pictureTag");
        return mav;
    }

    @RequestMapping(value = "/addTag", method = RequestMethod.GET)
    public ModelAndView pictureAddTag(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();

        List<Picture> allPictureNoTag = pictureTagService.findPicturesNoTag();
        Random random = new Random();
        int num = random.nextInt(allPictureNoTag.size());
        Picture picture = allPictureNoTag.get(num);
        mav.addObject("picture", picture);
        mav.setViewName("/picture/tagPicture");
        return mav;

    }


    @RequestMapping(value = "/random",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> randomPicture(@RequestBody final Map<String, Object> map){
        Map<String, Object> reply = new HashMap<String, Object>();
        List<Picture> allPictureNoTag = pictureTagService.findPicturesNoTag();
        Random random = new Random();
        int num = random.nextInt(allPictureNoTag.size());
        Picture picture = allPictureNoTag.get(num);
        reply.put("picId", picture.getId());
        reply.put("picURL", picture.getPicURL());
        reply.put("success", "成功");
        return reply;
    }

    @RequestMapping(value = "/addTags",method = RequestMethod.POST)
    public ModelAndView addTags(@RequestParam(value = "tags", required = false) String tags
            ,@RequestParam(value = "picId", required = false) String picId
            ,HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        Integer pictureId = Integer.valueOf(picId);
        if(tags != null){
            String[] tagList = tags.split(",");
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
        }

        mav.setViewName("/picture/tagPicture");

        return mav;
    }

    @Autowired
    public void setPictureTagService(PictureTagService pictureTagService) {
        this.pictureTagService = pictureTagService;
    }

    @Autowired
    public void setPictureService(PictureService pictureService) {
        this.pictureService = pictureService;
    }

    @Autowired
    public void setTagService(TagService tagService) {
        this.tagService = tagService;
    }
}
