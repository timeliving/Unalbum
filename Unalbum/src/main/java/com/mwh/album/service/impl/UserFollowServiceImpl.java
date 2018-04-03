package com.mwh.album.service.impl;

import com.mwh.album.mapper.UserFollowMapper;
import com.mwh.album.model.UserFollow;
import com.mwh.album.service.UserFollowService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class UserFollowServiceImpl implements UserFollowService {

    private UserFollowMapper userFollowMapper;
    public List<UserFollow> findByUserId(int userId) {
        List<UserFollow> userFollowList = userFollowMapper.findByUserId(userId);
        return userFollowList;
    }

    public UserFollow findByUserIdAndFollowUserId(int userId, int followUserId) {
        UserFollow userFollow = userFollowMapper.findByUserIdAndFollowUserId(userId, followUserId);
        if(userFollow == null){
            userFollow = new UserFollow();
        }
        return userFollow;
    }

    public void save(UserFollow userFollow) {
        userFollow.setCreateDate(new Date());
        userFollowMapper.save(userFollow);
    }

    public void delete(int userId, int followUserId) {
        userFollowMapper.delete(userId, followUserId);
    }

    @Resource
    public void setUserFollowMapper(UserFollowMapper userFollowMapper) {
        this.userFollowMapper = userFollowMapper;
    }
}
