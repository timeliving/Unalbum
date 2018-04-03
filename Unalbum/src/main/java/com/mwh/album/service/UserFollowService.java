package com.mwh.album.service;

import com.mwh.album.model.UserFollow;

import java.util.List;

public interface UserFollowService {

    List<UserFollow> findByUserId(int userId);
    UserFollow findByUserIdAndFollowUserId(int userId, int followUserId);
    void save(UserFollow userFollow);
    void delete(int userId, int followUserId);

}
