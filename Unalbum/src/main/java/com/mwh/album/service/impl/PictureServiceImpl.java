package com.mwh.album.service.impl;

import com.mwh.album.mapper.PictureMapper;
import com.mwh.album.model.Picture;
import com.mwh.album.service.PictureService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class PictureServiceImpl implements PictureService {

    private PictureMapper pictureMapper;
    public void save(Picture picture) {
        picture.setCreateDate(new Date());
        pictureMapper.save(picture);
    }

    public void delete(int id) {
        pictureMapper.delete(id);
    }

    public void update(Picture picture) {
        pictureMapper.update(picture);
    }

    public List<Picture> findAll() {
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findAll();
        return pictures;
    }

    public Picture findById(int id) {
        Picture picture = new Picture();
        picture = pictureMapper.findById(id);
        return picture;
    }

    public Picture findByPicName(String picName) {
        Picture picture = pictureMapper.findByPicName(picName);
        return picture;
    }

    public List<Picture> findByCategoryID(int picCategory) {
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findByCategoryID(picCategory);
        return pictures;
    }

    public Picture findByDateMostClose(String categoryName) {
        Picture picture = pictureMapper.findByDateMostClose(categoryName);
        return picture;
    }

    @Resource
    public void setPictureMapper(PictureMapper pictureMapper) {
        this.pictureMapper = pictureMapper;
    }
}
