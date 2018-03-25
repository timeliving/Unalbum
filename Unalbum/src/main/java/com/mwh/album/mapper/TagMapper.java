package com.mwh.album.mapper;

import com.mwh.album.model.Tag;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TagMapper {

    //查找所有标签
    List<Tag> findAll();
    //按标签ID查找标签
    Tag findById(int id);
    //按标签名查找标签
    List<Tag> findByTagName(@Param(value = "tagName") String tagName);
    //按标签名准确查找标签
    Tag findByTagNameNoBlur(@Param(value = "tagName") String tagName);


    //新增标签
    int save(Tag tag);
    //删除标签
    int delete(int id);
}
