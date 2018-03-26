package com.mwh.album.mapper;

import com.mwh.album.model.Gallery;
import com.mwh.album.model.Picture;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GalleryMapper {


    //查找所有相册
    List<Gallery> findAll();
    //按标签ID查找相册
    Gallery findById(int id);
    //根据用户ID查找相册
    List<Gallery> findByUserId(int userId);
    //根据用户ID查找用户默认相册之外的相册
    List<Gallery> findUserGalleryWithOutDefault(@Param(value = "userId") int userId);
    //根据用户ID查找用户默认相册
    Gallery findUserGallery(@Param(value = "userId") int userId
            ,@Param(value = "galleryName") String galleryName);
    //查找最新加入相册的一张图片
    Gallery findMostColsePicture(int id);
    //查找相册中所有的照片



    //新增相册
    int save(Gallery gallery);
    //修改相册分享状态
    int update(Gallery gallery);
    //删除相册
    int delete(int id);
    //修改封面图片
    int updateGalleryPagePicture(@Param(value = "pictureId") int pictureId
            ,@Param(value = "id") int id);

}
