package com.mwh.album.service.impl;

import com.mwh.album.common.PageUtil;
import com.mwh.album.mapper.GalleryPictureMapper;
import com.mwh.album.mapper.PictureCategoryMapper;
import com.mwh.album.model.*;
import com.mwh.album.service.GalleryPictureService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.rmi.CORBA.Util;
import java.util.*;

@Service
@Transactional
public class GalleryPictureServiceImpl implements GalleryPictureService {

    private GalleryPictureMapper galleryPictureMapper;
    private PictureCategoryMapper pictureCategoryMapper;

    public List<GalleryPicture> findAll() {
        return galleryPictureMapper.findAll();
    }

    public GalleryPicture findById(int id) {
        GalleryPicture galleryPicture = galleryPictureMapper.findById(id);
        if(galleryPicture == null) {
            galleryPicture = new GalleryPicture();
        }
        return galleryPicture;
    }

    public GalleryPicture findMostColsePicture(int galleryId) {
        GalleryPicture galleryPicture = galleryPictureMapper.findMostColsePicture(galleryId);
        if(galleryPicture == null) {
            galleryPicture = new GalleryPicture();
        }
        return galleryPicture;
    }

    public List<Picture> findPicturesByGalleryId(int galleryId) {
        List<Picture> pictureListByGallery = galleryPictureMapper.findPicturesByGalleryId(galleryId);
        return pictureListByGallery;
    }

    public List<Integer> findPictureIdByGalleryId(int galleryId) {
        List<Integer> pictureIdListByGallery = galleryPictureMapper.findPictureIdByGalleryId(galleryId);
        return pictureIdListByGallery;
    }


    public PageUtil<Map<Object, Object>> findPictureListByIdOrderByPage(int galleryId, int currIndex, int pageSize) {
        PageUtil<Map<Object, Object>> pageUtil =new PageUtil<Map<Object, Object>>();
        List<Picture> pictureList = galleryPictureMapper
                .findPictureListByIdOrderByPage(galleryId, currIndex, pageSize);
        List<GalleryPicture> galleryPicture = galleryPictureMapper.findGalleryPictureByIdOrderByPage(galleryId, currIndex, pageSize);
        List<Map<Object, Object>> galleryPictureList = galleryPictureTurnMap(pictureList, galleryPicture);
        int ind = currIndex / pageSize + 1;
        int count = countByGalleryId(galleryId);
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
        pageUtil.setList(galleryPictureList);

        return pageUtil;
    }

    private List<Map<Object,Object>> galleryPictureTurnMap(List<Picture> picturesList
            , List<GalleryPicture> galleryPicture){
        List<Map<Object, Object>> galleryPictureList = new ArrayList<Map<Object, Object>>();
        for (int i = 0; i <= galleryPicture.size() - 1; i++){
            Map<Object, Object> pictureMap = new HashMap<Object, Object>();
            pictureMap.put("id", galleryPicture.get(i).getGallery().getId());
            pictureMap.put("pictureId", galleryPicture.get(i).getPictureId());
            pictureMap.put("picName",picturesList.get(i).getPicName());
            pictureMap.put("picURL", picturesList.get(i).getPicURL());
            PictureCategory pictureCategory = pictureCategoryMapper
                    .findById(picturesList.get(i).getPicCategory());
            pictureMap.put("picCategory"
                    , pictureCategory.getCategoryName());
            pictureMap.put("user", picturesList.get(i).getUser());
            pictureMap.put("createDate", galleryPicture.get(i).getCreateDate());
            galleryPictureList.add(pictureMap);
        }
        return galleryPictureList;
    }

    public void save(GalleryPicture galleryPicture) {
        galleryPicture.setCreateDate(new Date());

        galleryPictureMapper.save(galleryPicture);
    }

    public void delete(int id) {
        galleryPictureMapper.delete(id);
    }

    public void deleteByGalleryIdAndPictureId(int galleryId, int pictureId) {
        galleryPictureMapper.deleteByGalleryIdAndPictureId(galleryId, pictureId);
    }

    public void deleteByGalleryId(int galleryId) {
        galleryPictureMapper.deleteByGalleryId(galleryId);
    }

    public int countByGalleryId(int galleryId) {
        return galleryPictureMapper.countByGalleryId(galleryId);
    }

    @Resource
    public void setGalleryPictureMapper(GalleryPictureMapper galleryPictureMapper) {
        this.galleryPictureMapper = galleryPictureMapper;
    }
    @Resource
    public void setPictureCategoryMapper(PictureCategoryMapper pictureCategoryMapper) {
        this.pictureCategoryMapper = pictureCategoryMapper;
    }
}
