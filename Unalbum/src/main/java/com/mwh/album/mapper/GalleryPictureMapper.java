package com.mwh.album.mapper;

import com.mwh.album.model.Gallery;
import com.mwh.album.model.GalleryPicture;
import com.mwh.album.model.Picture;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GalleryPictureMapper {

    //查找所有
    List<GalleryPicture> findAll();
    //根据ID查找相册图片
    GalleryPicture findById(int id);
    //根据相册ID查找对应的图片
    List<Picture> findPicturesByGalleryId(
            @Param(value = "galleryId") int galleryId);
    //查找最新加入相册的一张图片
    GalleryPicture findMostColsePicture(@Param(value = "galleryId") int galleryId);


    //新增相册
    int save(GalleryPicture galleryPicture);
    //删除相册
    int delete(int id);
    //根据相册ID和照片ID删除
    int deleteByGalleryIdAndPictureId(@Param(value = "galleryId") int galleryId
            ,@Param(value = "pictureId") int pictureId);
}
