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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
                mav.addObject("pageUtil", pageUtil);
            }else{
                PageUtil<Picture> pageUtil =new PageUtil<Picture>();
                pageUtil = pictureService
                        .findAllByTagAndPage(keyword
                                , index, pageSize);
                mav.addObject("pageUtil", pageUtil);
            }
        }

        mav.addObject("keyword", keyword);
        mav.setViewName("search/pictureTag");
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
