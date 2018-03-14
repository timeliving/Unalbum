package com.mwh.album.service;

import com.mwh.album.model.Picture;

import java.util.List;

/**
 * Picture service.
 * @author mwh
 * @Date 2018年3月12日 16点57分
 */

public interface PictureService {

    public void save(Picture picture);

    public void delete(int id);

    public void update(Picture picture);

    public List<Picture> findAll();
    public Picture findById(int id);
    public Picture findByPicName(String userName);
    public List<Picture> findByCategoryID(int picCategory);

}
