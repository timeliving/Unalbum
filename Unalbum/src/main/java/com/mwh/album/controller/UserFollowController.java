package com.mwh.album.controller;

import com.mwh.album.model.User;
import com.mwh.album.model.UserFollow;
import com.mwh.album.service.UserFollowService;
import com.mwh.album.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("follow")
public class UserFollowController extends BaseController {

    private UserFollowService userFollowService;
    private UserService userService;

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

    @Autowired
    public void setUserFollowService(UserFollowService userFollowService) {
        this.userFollowService = userFollowService;
    }

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }
}
