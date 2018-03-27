package com.mwh.album.service.impl;

import com.mwh.album.mapper.GalleryMapper;
import com.mwh.album.model.Gallery;
import com.mwh.album.service.GalleryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class GalleryServiceImpl implements GalleryService{

    private GalleryMapper  galleryMapper;

    public List<Gallery> findAll() {
        return galleryMapper.findAll();
    }

    public Gallery findById(int id) {
        Gallery gallery = galleryMapper.findById(id);
        if(gallery == null){
            gallery = new Gallery();
        }
        return gallery;
    }


    public List<Gallery> findByUserId(int userId) {
        List<Gallery> galleryList = galleryMapper.findByUserId(userId);
        return galleryList;
    }

    public List<Gallery> findUserGalleryWithOutDefault(int userId) {
        List<Gallery> galleryList = galleryMapper.findUserGalleryWithOutDefault(userId);
        return galleryList;
    }

    public Gallery findUserGallery(int userId, String galleryName) {
        Gallery gallery = galleryMapper.findUserGallery(userId, galleryName);
        if(gallery == null){
            gallery = new Gallery();
        }
        return gallery;
    }

    public void save(Gallery gallery) {
        gallery.setCreateDate(new Date());
        gallery.setIsShare(1);
        galleryMapper.save(gallery);
    }

    public void delete(int id) {
        galleryMapper.delete(id);
    }

    public void updateGalleryPagePicture(int pictureId, int id) {
        Gallery gallery = findById(id);
        if(gallery.getId() != null){
            if(gallery.getPagePicture() == null){
                galleryMapper.updateGalleryPagePicture(pictureId, id);
            }else if(gallery.getPagePicture()!=null &&
                    !gallery.getPagePicture().getId().equals(pictureId)){
                galleryMapper.updateGalleryPagePicture(pictureId, id);
            }
        }
    }

    public void update(Gallery gallery) {
        Gallery gallery1 = findById(gallery.getId());
        if(gallery1.getId() != null){
            if(!gallery1.getGalleryName().equals(gallery.getGalleryName())){
                gallery1.setGalleryName(gallery.getGalleryName());
            }
            if(!gallery1.getIsShare().equals(gallery.getIsShare())){
                gallery1.setIsShare(gallery.getIsShare());
            }
        }
        galleryMapper.update(gallery);
    }

    @Resource
    public void setGalleryMapper(GalleryMapper galleryMapper) {
        this.galleryMapper = galleryMapper;
    }
}
