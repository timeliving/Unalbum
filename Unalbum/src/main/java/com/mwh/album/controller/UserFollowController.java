package com.mwh.album.controller;

import com.mwh.album.model.Picture;
import com.mwh.album.model.User;
import com.mwh.album.model.UserFollow;
import com.mwh.album.service.PictureService;
import com.mwh.album.service.UserFollowService;
import com.mwh.album.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("follow")
public class UserFollowController extends BaseController {

    private UserFollowService userFollowService;
    private UserService userService;
    private PictureService pictureService;

    @RequestMapping(value = "/user", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> followUser(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, Object> reply = new HashMap<String, Object>();
        Integer followUserId = Integer.valueOf(map.get("followUserId").toString());
        Integer userId = Integer.valueOf(map.get("userId").toString());
        User user = userService.findById(userId);
        User followUser = userService.findById(followUserId);
        UserFollow userFollow = new UserFollow();
        userFollow.setUser(user);
        userFollow.setFollowUser(followUser);
        userFollowService.save(userFollow);
        reply.put("success", "成功");
        reply.put("userId", userId);
        reply.put("followUserId", followUserId);
        return reply;
    }


    @RequestMapping(value = "/unFollow", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> unFollowUser(@RequestBody final Map<String, Object> map
            , HttpServletRequest request){
        Map<String, Object> reply = new HashMap<String, Object>();
        Integer followUserId = Integer.valueOf(map.get("followUserId").toString());
        Integer userId = Integer.valueOf(map.get("userId").toString());
        userFollowService.delete(userId,followUserId);
        reply.put("success", "成功");
        reply.put("userId", userId);
        reply.put("followUserId", followUserId);
        return reply;
    }

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public ModelAndView userFollow(HttpServletRequest request){
        ModelAndView mav = new ModelAndView();
        if(getSessionUser(request).getId() == null){
            mav.addObject("errorUser", "用户登录后才可查看关注");
            mav.setViewName("login");
        }else{
            User user = getSessionUser(request);
            List<UserFollow> userFollowList = userFollowService
                    .findByUserId(user.getId());
            Picture pagePicture = pictureService
                    .findyByUserMostClose(user.getId());
            List<Picture> followUserPage = new ArrayList<Picture>();
            if(!userFollowList.isEmpty()) {
                for (UserFollow userFollow : userFollowList) {
                    Picture picture = new Picture();
                    picture = pictureService
                            .findyByUserMostClose(userFollow.getFollowUser().getId());
                    followUserPage.add(picture);
                }
            }
            mav.addObject("pagePicture", pagePicture);
            mav.addObject("user", user);
            mav.addObject("userFollowList", userFollowList);
            mav.addObject("followUserPage", followUserPage);
            mav.setViewName("user/userFollow");
        }
        return mav;
    }

    @Autowired
    public void setUserFollowService(UserFollowService userFollowService) {
        this.userFollowService = userFollowService;
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
