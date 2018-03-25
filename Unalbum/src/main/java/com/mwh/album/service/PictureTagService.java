package com.mwh.album.service;

import com.mwh.album.model.PictureTag;

import java.util.List;

public interface PictureTagService {

    //查找所有标签
    List<PictureTag> findAll();
    //按标签ID查找标签
    List<PictureTag> findByPictureId(int pictureId);
    //按标签名查找标签
    List<PictureTag> findByTagId(int tagId);
    //按ID查找
    PictureTag findByTagIdAndPictureId(int tagId, int pictureId);




    //新增标签
    void save(PictureTag pictureTag);
    //删除标签
    void delete(int id);
    //根据图片ID删除记录
    void deleteByPictureId(int pictureId);

}
