package com.mwh.album.service.impl;

import com.mwh.album.mapper.PictureCategoryMapper;
import com.mwh.album.model.PictureCategory;
import com.mwh.album.service.PictureCategoryService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

public class PictureCategoryServiceImpl implements PictureCategoryService {

    private PictureCategoryMapper pictureCategoryMapper;
    public List<PictureCategory> findAll() {
        List<PictureCategory> categories = new ArrayList<PictureCategory>();
        categories = pictureCategoryMapper.findAll();
        return categories;
    }

    public void save(PictureCategory pictureCategory) {
        pictureCategoryMapper.save(pictureCategory);
    }

    public void delete(int id) {
        pictureCategoryMapper.delete(id);
    }

    public void update(PictureCategory pictureCategory) {
        pictureCategoryMapper.update(pictureCategory);
    }

    @Resource
    public void setPictureCategoryMapper(PictureCategoryMapper pictureCategoryMapper) {
        this.pictureCategoryMapper = pictureCategoryMapper;
    }
}
