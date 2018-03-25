package com.mwh.album.service;

import com.mwh.album.model.Gallery;
import com.mwh.album.model.GalleryPicture;
import com.mwh.album.model.Picture;

import java.util.List;

public interface GalleryPictureService {

    //查找所有
    List<GalleryPicture> findAll();
    //根据ID查找相册图片
    GalleryPicture findById(int id);
    //根据相册ID查找对应的图片
    List<Picture> findPicturesByGalleryId(int galleryId);
    //查找最新加入相册的一张图片
    GalleryPicture findMostColsePicture(int galleryId);


    //新增相册
    void save(GalleryPicture galleryPicture);
    //删除相册
    void delete(int id);
    //根据相册ID和照片ID删除
    void deleteByGalleryIdAndPictureId(int galleryId, int pictureId);

}
