package com.mwh.album.mapper;

import com.mwh.album.model.Picture;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Picture mapper.
 * @author mwh
 * @Date 2018年3月12日 16点50分
 */

public interface PictureMapper {

    //查找所有图片
    List<Picture> findAll();
    //按图片ID查找图片
    Picture findById(int id);
    //按图片名查找图片
    Picture findByPicName(String picName);
    //按图片类别ID查找图片
    List<Picture> findByCategoryID(int picCategory);
    //根据图片分类ID查询最新发表的一张图片
    Picture findByDateMostClose(@Param(value = "categoryName") String categoryName);

    //新增图片
    int  save(Picture picture);
    //删除图片
    int delete(int id);
    //修改图片
    int update(Picture picture);

    //修改图片喜欢数 +1/-1
    int updatePictureLikes(int id, int picLikes);


}
