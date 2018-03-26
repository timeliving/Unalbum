package com.mwh.album.service.impl;

import com.mwh.album.common.PageUtil;
import com.mwh.album.mapper.PictureMapper;
import com.mwh.album.mapper.PictureTagMapper;
import com.mwh.album.mapper.TagMapper;
import com.mwh.album.mapper.UserLikeCollectionMapper;
import com.mwh.album.model.Picture;
import com.mwh.album.model.PictureTag;
import com.mwh.album.model.Tag;
import com.mwh.album.model.UserLikeCollection;
import com.mwh.album.service.PictureService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

@Service
@Transactional
public class PictureServiceImpl implements PictureService {

    private PictureMapper pictureMapper;
    private UserLikeCollectionMapper userLikeCollectionMapper;
    private PictureTagMapper pictureTagMapper;
    private TagMapper tagMapper;

    public int save(Picture picture) {
        picture.setCreateDate(new Date());
        pictureMapper.save(picture);
        int id = picture.getId();
        return id;
    }

    public void delete(int id) {
        pictureMapper.delete(id);
    }

    public void update(Picture picture) {
        Picture pic = findById(picture.getId());
        if(pic.getId() != null){
            if(pic.getPicName().equals(picture.getPicName())){
                pic.setPicName(picture.getPicName());
            }
            if(pic.getPicCategory() != picture.getPicCategory()){
                pic.setPicCategory(picture.getPicCategory());
            }
            if(pic.getPicProfile() == picture.getPicProfile()){
                pic.setPicProfile(picture.getPicProfile());
            }
            if(pic.getIsShare().equals(picture.getIsShare())){
                pic.setIsShare(picture.getIsShare());
            }
        }
        pictureMapper.update(pic);
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

    public PageUtil<Picture> findAllByPage(int currIndex, int pageSize) {
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findAllByPage
                (currIndex, pageSize);

        int ind = currIndex / pageSize + 1;
        int count = countAll();
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

    public PageUtil<Map<Object, Object>> findAllByPageWithUserId(int userId
            , int currIndex, int pageSize){
        PageUtil<Map<Object, Object>> pageUtil = new PageUtil<Map<Object, Object>>();
        List<Picture> pictures = new ArrayList<Picture>();
        List<UserLikeCollection> likeCollectionByUserList = userLikeCollectionMapper
                .findByUserId(userId);
        pictures = pictureMapper.findAllByPage
                (currIndex, pageSize);
        List<Map<Object, Object>> pictureList = pictureTurnMap(pictures, likeCollectionByUserList);
        int ind = currIndex / pageSize + 1;
        int count = countAll();
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
        pageUtil.setList(pictureList);
        return pageUtil;
    }

    public List<Integer> getPictureIdList(String tagName){
        List<Tag> tagList = tagMapper.findByTagName(tagName);
        List<Integer> pictureIdList = new ArrayList<Integer>();
        if(!tagList.isEmpty()){
            for(Tag tag : tagList){
                List<PictureTag> pictureTagList = pictureTagMapper
                        .findByTagId(tag.getId());
                if(!pictureTagList.isEmpty()){
                    for(PictureTag pictureTag : pictureTagList){
                        if(pictureTag.getPictureId() != null){
                            pictureIdList.add(pictureTag.getPictureId());
                        }
                    }
                }
            }
        }
        return pictureIdList;
    }

    public PageUtil<Picture> findAllByTagAndPage(String tagName
            , int currIndex, int pageSize) {
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        List<Picture> pictures = new ArrayList<Picture>();
        List<Integer> pictureIdList = this.getPictureIdList(tagName);
        pictures = this.findByPictureIdList(pictureIdList);
        int ind = currIndex / pageSize + 1;
        int count = this.countByTag(tagName);
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

    public PageUtil<Map<Object, Object>> findAllByTagAndPageWithUserId(String tagName
            , int userId, int currIndex, int pageSize) {
        PageUtil<Map<Object, Object>> pageUtil = new PageUtil<Map<Object, Object>>();
        List<Picture> pictures = new ArrayList<Picture>();
        List<UserLikeCollection> likeCollectionByUserList = userLikeCollectionMapper
                .findByUserId(userId);
        List<Integer> pictureIdList = this.getPictureIdList(tagName);
        pictures = this.findByPictureIdList(pictureIdList);
        List<Map<Object, Object>> pictureList = pictureTurnMap(pictures, likeCollectionByUserList);
        int ind = currIndex / pageSize + 1;
        int count = this.countByTag(tagName);
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
        pageUtil.setList(pictureList);
        return pageUtil;
    }

    public Picture findById(int id) {
        Picture picture = new Picture();
        picture = pictureMapper.findById(id);
        return picture;
    }


    public PageUtil<Picture> findByUserIdOrderByPage(int userId, int currIndex, int pageSize) {
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findByUserIdOrderByPage(userId
                , currIndex, pageSize);

        int ind = currIndex / pageSize + 1;
        int count = countByUserId(userId);
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

    public PageUtil<Picture> findByUserIdOrderByPageAndDate(int userId, int currIndex, int pageSize, Date beginDate, Date endDate) {
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findByUserIdOrderByPageAndDate(userId
                , currIndex, pageSize, beginDate, endDate);
        int ind = currIndex / pageSize + 1;
        int count = countByDate(userId, beginDate, endDate);
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

    public List<Picture> findByUserId(int userId, int currIndex, int pageSize) {
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findByUserIdOrderByPage
                (userId, currIndex, pageSize);
        return pictures;
    }

    /**
     * 在没有用户登录的情况下展示分页分类图片
     * @param picCategory
     * @param currIndex
     * @param pageSize
     * @return
     */
    public PageUtil<Picture> findByCategoryIDOrderByPage(int picCategory, int currIndex, int pageSize) {
        PageUtil<Picture> pageUtil = new PageUtil<Picture>();
        List<Picture> pictures = new ArrayList<Picture>();
        pictures = pictureMapper.findByCategoryIDOrderByPage
                (picCategory, currIndex, pageSize);

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



    /**
     * 在已经有用户登录的情况下展示分页分类图片
     * @param picCategory
     * @param user
     * @param currIndex
     * @param pageSize
     * @return
     */
    public PageUtil<Map<Object, Object>> findByCategoryIDOrderByPageWithUserId(int picCategory, int user, int currIndex, int pageSize) {
        PageUtil<Map<Object, Object>> pageUtil = new PageUtil<Map<Object, Object>>();
        List<Picture> pictures = new ArrayList<Picture>();
        List<UserLikeCollection> likeCollectionByUserList = userLikeCollectionMapper
                .findByUserId(user);
        pictures = pictureMapper.findByCategoryIDOrderByPage
                (picCategory, currIndex, pageSize);
        List<Map<Object, Object>> pictureList = pictureTurnMap(pictures, likeCollectionByUserList);
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
        pageUtil.setList(pictureList);
        return pageUtil;
    }

    private List<Map<Object,Object>> pictureTurnMap(List<Picture> picturesList
            , List<UserLikeCollection> likeCollectionList){
        List<Map<Object, Object>> pictureList = new ArrayList<Map<Object, Object>>();
        for(Picture picture : picturesList){
            Map<Object, Object> pictureMap = new HashMap<Object, Object>();
            for(UserLikeCollection userLikeCollection : likeCollectionList){
                if(picture.getId().equals(userLikeCollection.getPicture().getId())){
                    pictureMap.put("id", picture.getId());
                    pictureMap.put("picName",picture.getPicName());
                    pictureMap.put("picURL", picture.getPicURL());
                    pictureMap.put("picCategory", picture.getPicCategory());
                    pictureMap.put("user", picture.getUser());
                    pictureMap.put("picProfile", picture.getPicProfile());
                    pictureMap.put("isLike", userLikeCollection.getIsLike());
                    pictureMap.put("isCollection", userLikeCollection.getIsCollection());
                }
            }
            if(!pictureMap.isEmpty()){
                pictureList.add(pictureMap);
            }else{
                pictureMap.put("id", picture.getId());
                pictureMap.put("picName",picture.getPicName());
                pictureMap.put("picURL", picture.getPicURL());
                pictureMap.put("picCategory", picture.getPicCategory());
                pictureMap.put("user", picture.getUser());
                pictureMap.put("picProfile", picture.getPicProfile());
                pictureMap.put("isLike", 0);
                pictureMap.put("isCollection", 0);
                pictureList.add(pictureMap);
            }
        }
        return pictureList;
    }

    public Picture findByDateMostClose(String categoryName) {
        Picture picture = pictureMapper.findByDateMostClose(categoryName);
        return picture;
    }

    public List<Picture> findByPictureLikes(Date yesterday) {
        List<Picture> picture = pictureMapper.findByPictureLikes(yesterday);
        return picture;
    }

    public List<Picture> findByPictureIdList(List<Integer> pictureIdList) {
        List<Picture> pictureList = new ArrayList<Picture>();
        if(!pictureIdList.isEmpty()){
            for(Integer pictureId : pictureIdList){
                Picture picture = this.findById(pictureId);
                pictureList.add(picture);
            }
        }
        return pictureList;
    }

    public int countByCategoryId(int picCategory) {
        return pictureMapper.countByCategory(picCategory);
    }

    public int countAll(){
        return pictureMapper.countAll();
    }

    public int countByTag(String tagName) {
        return pictureMapper.countByTag(tagName);
    }

    public int countByUserId(int userId) {
        return pictureMapper.countByUserId(userId);
    }

    public int countByDate(int userId, Date beginDate, Date endDate) {
        return pictureMapper.countByDate(userId, beginDate, endDate);
    }

    @Resource
    public void setPictureMapper(PictureMapper pictureMapper) {
        this.pictureMapper = pictureMapper;
    }
    @Resource
    public void setUserLikeCollectionMapper(UserLikeCollectionMapper userLikeCollectionMapper) {
        this.userLikeCollectionMapper = userLikeCollectionMapper;
    }
    @Resource
    public void setPictureTagMapper(PictureTagMapper pictureTagMapper) {
        this.pictureTagMapper = pictureTagMapper;
    }
    @Resource
    public void setTagMapper(TagMapper tagMapper) {
        this.tagMapper = tagMapper;
    }
}
