package com.mwh.album.mapper;

import com.mwh.album.model.Picture;

import java.util.List;

/**
 * Picture mapper.
 * @author mwh
 * @Date 2018年3月12日 16点50分
 */

public interface PictureMapper {

    //查找所有图片
    public List<Picture> findAll();
    //按图片ID查找图片
    public Picture findById(int id);
    //按图片名查找图片
    public Picture findByPicName(String picName);
    //按图片类别ID查找图片
    public List<Picture> findByCategoryID(int picCategory);

    //新增图片
    public int  save(Picture picture);
    //删除图片
    public int delete(int id);
    //修改图片
    public int update(Picture picture);


}
