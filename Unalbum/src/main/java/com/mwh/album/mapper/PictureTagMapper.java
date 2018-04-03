package com.mwh.album.mapper;

import com.mwh.album.model.Picture;
import com.mwh.album.model.PictureTag;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PictureTagMapper {

    //查找所有标签
    List<PictureTag> findAll();
    //按标签ID查找标签
    List<PictureTag> findByPictureId(@Param(value = "pictureId") int pictureId);
    //按标签名查找标签
    List<PictureTag> findByTagId(@Param(value = "tagId") int tagId);
    //按ID查找
    PictureTag findByTagIdAndPictureId(@Param(value = "tagId") int tagId
            ,@Param(value = "pictureId") int pictureId);
    //查找没有标签的所有相片
    List<Picture> findPicturesNoTag();




    //新增标签
    int save(PictureTag pictureTag);
    //删除标签
    int delete(int id);
    //根据相片ID删除图片标签
    int deleteByPictureId(@Param(value = "pictureId") int pictureId);


}
