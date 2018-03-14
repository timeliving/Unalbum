package com.mwh.album.service;

import com.mwh.album.model.PictureCategory;

import java.util.List;

/**
 * PictureCategory service.
 * @author mwh
 * @Date 2018年3月12日 16点59分
 */
public interface PictureCategoryService {

    public List<PictureCategory> findAll();

    //新增图片
    public void  save(PictureCategory pictureCategory);
    //删除图片
    public void delete(int id);
    //修改图片
    public void update(PictureCategory pictureCategory);

}
