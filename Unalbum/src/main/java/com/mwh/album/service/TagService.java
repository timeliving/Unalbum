package com.mwh.album.service;

import com.mwh.album.model.Tag;

import java.util.List;

public interface TagService {

    //查找所有标签
    List<Tag> findAll();
    //按标签ID查找标签
    Tag findById(int id);
    //按标签名查找标签
    List<Tag> findByTagName(String tagName);
    //按标签名准确查找
    Tag findByTagNameNoBlur(String tagName);


    //新增标签
    int save(Tag user);
    //删除标签
    void delete(int id);

}
