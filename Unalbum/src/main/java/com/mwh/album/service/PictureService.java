package com.mwh.album.service;

import com.mwh.album.common.PageUtil;
import com.mwh.album.model.Picture;

import java.util.Date;
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
    PageUtil<Picture> findByCategoryIDOrderByPage(int picCategory, int currIndex, int pageSize);
    Picture findByDateMostClose(String categoryName);
    List<Picture> findByPictureLikes(Date yesterday);

    int countByCategoryId(int picCategory);

}
