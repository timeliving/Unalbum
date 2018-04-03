package com.mwh.album.service;

import com.mwh.album.common.PageUtil;
import com.mwh.album.model.Picture;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Picture service.
 * @author mwh
 * @Date 2018年3月12日 16点57分
 */

public interface PictureService {

    int save(Picture picture);

    void delete(int id);

    void update(Picture picture);
    void updatePictureLikes(Picture picture);
    void updatePictureCollection(Picture picture);
    PageUtil<Picture> findAllByPage(int currIndex, int pageSize);
    PageUtil<Map<Object, Object>> findAllByPageWithUserId(int userId
            , int currIndex, int pageSize);
    PageUtil<Picture> findAllByTagAndPage(String tagName
            , int currIndex, int pageSize);
    PageUtil<Map<Object, Object>> findAllByTagAndPageWithUserId
            (String tagName,int userId, int currIndex, int pageSize);

    Picture findById(int id);
    Picture findyByUserMostClose(int userId);
    PageUtil<Picture> findByUserIdOrderByPage(int userId, int currIndex, int pageSize);

    PageUtil<Picture> findByUserIdOrderByPageAndDate(int userId, int currIndex, int pageSize, Date beginDate, Date endDate);
    List<Picture> findByUserId(int userId, int currIndex, int pageSize);

    PageUtil<Picture> findByCategoryIDOrderByPage(int picCategory
            , int currIndex, int pageSize);
    PageUtil<Map<Object, Object>> findByCategoryIDOrderByPageWithUserId(int picCategory
            , int user, int currIndex, int pageSize);

    Picture findByDateMostClose(String categoryName);
    List<Picture> findByPictureLikes(Date yesterday);
    List<Picture> findByPictureIdList(List<Integer> pictureIdList);
    int countByCategoryId(int picCategory);
    int countAll();
    int countByTag(String tagName);
    int countByUserId(int userId);
    int countByDate(int userId, Date beginDate, Date endDate);

}
