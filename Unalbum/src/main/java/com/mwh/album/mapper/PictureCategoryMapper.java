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
    public List<PictureCategory> findAll();

    //新增图片
    public int  save(PictureCategory pictureCategory);
    //删除图片
    public int delete(int id);
    //修改图片
    public int update(PictureCategory pictureCategory);

}
