package com.mwh.album.mapper;

import com.mwh.album.model.UserLikeCollection;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserLikeCollectionMapper {


    //按用户ID查找
    List<UserLikeCollection> findByUserId(int userId);
    //按图片ID查找
    List<UserLikeCollection> findByPictureId(int pictureId);
    //按用户ID和图片ID同时查找
    UserLikeCollection findByUserIdAndPictureId(int userId, int pictureId);

    //新增用户喜欢收藏
    int save(UserLikeCollection userLikeCollection);
    //删除记录
    int delete(int id);
    //根据图片ID删除收藏
    int deleteByPictureId(@Param(value = "pictureId") int pictureId);

    //修改用户喜欢收藏
    int update(UserLikeCollection userLikeCollection);

}
