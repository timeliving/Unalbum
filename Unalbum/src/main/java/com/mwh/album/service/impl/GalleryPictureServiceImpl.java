package com.mwh.album.service.impl;

import com.mwh.album.mapper.GalleryPictureMapper;
import com.mwh.album.model.Gallery;
import com.mwh.album.model.GalleryPicture;
import com.mwh.album.model.Picture;
import com.mwh.album.service.GalleryPictureService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class GalleryPictureServiceImpl implements GalleryPictureService {

    private GalleryPictureMapper galleryPictureMapper;

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

    @Resource
    public void setGalleryPictureMapper(GalleryPictureMapper galleryPictureMapper) {
        this.galleryPictureMapper = galleryPictureMapper;
    }
}
