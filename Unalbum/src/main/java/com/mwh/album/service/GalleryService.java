package com.mwh.album.service;

import com.mwh.album.model.Gallery;

import java.util.List;

public interface GalleryService {

    //查找所有相册
    List<Gallery> findAll();
    //按标签ID查找相册
    Gallery findById(int id);
    //根据用户ID查找相册
    List<Gallery> findByUserId(int userId);
    //根据用户ID查找用户默认相册
    Gallery findUserGallery(int userId,String galleryName);



    //新增相册
    void save(Gallery gallery);
    //删除相册
    void delete(int id);
    //修改封面图片
    void updateGalleryPagePicture(int pictureId, int id);

}
