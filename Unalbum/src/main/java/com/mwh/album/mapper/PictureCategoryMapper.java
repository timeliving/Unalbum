package com.mwh.album.mapper;

import com.mwh.album.model.PictureCategory;

import java.util.List;

/**
 * PictureCategory mapper.
 * @author mwh
 * @Date 2018年3月12日 16点37分
 */

public interface PictureCategoryMapper {

    //查找所有图片类别
    List<PictureCategory> findAll();

    PictureCategory findByCategoryName(String categoryName);
    //根据ID查找
    PictureCategory findById(int id);

    //新增图片
    int  save(PictureCategory pictureCategory);
    //删除图片
    int delete(int id);
    //修改图片
    int update(PictureCategory pictureCategory);

}
