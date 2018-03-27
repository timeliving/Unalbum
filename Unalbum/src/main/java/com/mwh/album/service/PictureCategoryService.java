package com.mwh.album.service;

import com.mwh.album.model.PictureCategory;

import java.util.List;

/**
 * PictureCategory service.
 * @author mwh
 * @Date 2018年3月12日 16点59分
 */
public interface PictureCategoryService {

    List<PictureCategory> findAll();
    PictureCategory findByCategoryName(String categoryName);
    PictureCategory findById(int id);


    //新增图片
    void  save(PictureCategory pictureCategory);
    //删除图片
    void delete(int id);
    //修改图片
    void update(PictureCategory pictureCategory);

}
