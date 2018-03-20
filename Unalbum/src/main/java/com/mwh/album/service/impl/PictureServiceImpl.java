package com.mwh.album.service.impl;

import com.mwh.album.common.PageUtil;
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

    public void updatePictureLikes(Picture picture) {
        Picture picture1 = findById(picture.getId());
        if (picture1.getPicLikes() != picture.getPicLikes()){
            picture1.setPicLikes(picture.getPicLikes());
        }
        pictureMapper.updatePictureLikes(picture);
    }

    public void updatePictureCollection(Picture picture) {
        Picture picture1 = findById(picture.getId());
        if (picture1.getPicCollection() != picture.getPicCollection()){
            picture1.setPicCollection(picture.getPicCollection());
        }
        pictureMapper.updatePictureCollection(picture);
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

    public PageUtil<Picture> findByCategoryIDOrderByPage(int picCategory, int currIndex, int pageSize) {
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findByCategoryIDOrderByPage(picCategory, currIndex, pageSize);
        int ind = currIndex / pageSize + 1;
        int count = countByCategoryId(picCategory);
        int pageNumber;
        if (count % pageSize == 0) {
            pageNumber = count / pageSize;
        } else {
            pageNumber = count / pageSize + 1;
        }
        pageUtil.setIndex(ind);
        pageUtil.setPageSize(pageSize);
        pageUtil.setCount(count);
        pageUtil.setPageNumber(pageNumber);
        pageUtil.setList(pictures);
        return pageUtil;
    }

    public Picture findByDateMostClose(String categoryName) {
        Picture picture = pictureMapper.findByDateMostClose(categoryName);
        return picture;
    }

    public List<Picture> findByPictureLikes(Date yesterday) {
        List<Picture> picture = pictureMapper.findByPictureLikes(yesterday);
        return picture;
    }

    public int countByCategoryId(int picCategory) {
        return pictureMapper.countByCategory(picCategory);
    }


    @Resource
    public void setPictureMapper(PictureMapper pictureMapper) {
        this.pictureMapper = pictureMapper;
    }
}
