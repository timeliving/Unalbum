package com.mwh.album.service;

import com.mwh.album.model.UserLikeCollection;

import java.util.List;

public interface UserLikeCollectionService {

    //按用户ID查找
    List<UserLikeCollection> findByUserId(int userId);
    //按图片ID查找
    List<UserLikeCollection> findByPictureId(int pictureId);
    //按用户ID和图片ID同时查找
    UserLikeCollection findByUserIdAndPictureId(int userId, int pictureId);

    //新增用户喜欢收藏
    void save(UserLikeCollection userLikeCollection);
    //删除记录
    void delete(int id);
    //根据图片ID删除记录
    void deleteByPictureId(int pictureId);
    //修改用户喜欢收藏
    void update(UserLikeCollection userLikeCollection);

}
