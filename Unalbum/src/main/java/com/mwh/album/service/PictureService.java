package com.mwh.album.service;

import com.mwh.album.model.Picture;

import java.util.List;

/**
 * Picture service.
 * @author mwh
 * @Date 2018年3月12日 16点57分
 */

public interface PictureService {

    void save(Picture picture);

    void delete(int id);

    void update(Picture picture);

    List<Picture> findAll();
    Picture findById(int id);
    Picture findByPicName(String userName);
    List<Picture> findByCategoryID(int picCategory);

}
