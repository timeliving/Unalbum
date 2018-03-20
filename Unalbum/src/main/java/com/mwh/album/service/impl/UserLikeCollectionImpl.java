package com.mwh.album.service.impl;

import com.mwh.album.mapper.UserLikeCollectionMapper;
import com.mwh.album.model.UserLikeCollection;
import com.mwh.album.service.UserLikeCollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserLikeCollectionImpl implements UserLikeCollectionService {

    private UserLikeCollectionMapper userLikeCollectionMapper;

    public List<UserLikeCollection> findByUserId(int userId) {
        List<UserLikeCollection> userLikeCollectionList = userLikeCollectionMapper.findByUserId(userId);
        return userLikeCollectionList;
    }

    public List<UserLikeCollection> findByPictureId(int pictureId) {
        List<UserLikeCollection> userLikeCollectionList = userLikeCollectionMapper.findByPictureId(pictureId);
        return userLikeCollectionList;
    }

    public UserLikeCollection findByUserIdAndPictureId(int userId, int pictureId) {
        UserLikeCollection userLikeCollection = userLikeCollectionMapper.findByUserIdAndPictureId(userId, pictureId);
        if(userLikeCollection == null){
            return new UserLikeCollection();
        }
        return userLikeCollection;
    }

    public void save(UserLikeCollection userLikeCollection) {
        UserLikeCollection likeCollection = findByUserIdAndPictureId(userLikeCollection.getUser().getId()
            ,userLikeCollection.getPicture().getId());
        if(likeCollection.getId() != null){
            this.update(userLikeCollection);
        }else{
            userLikeCollectionMapper.save(userLikeCollection);
        }
    }

    public void delete(int id) {
        userLikeCollectionMapper.delete(id);
    }

    public void update(UserLikeCollection userLikeCollection) {
        UserLikeCollection likeCollection = findByUserIdAndPictureId(userLikeCollection.getUser().getId()
                ,userLikeCollection.getPicture().getId());
        if(likeCollection.getIsLike() != userLikeCollection.getIsLike()) {
            likeCollection.setIsLike(userLikeCollection.getIsLike());
        }
        if(likeCollection.getIsCollection() != userLikeCollection.getIsCollection()){
            likeCollection.setIsCollection(userLikeCollection.getIsCollection());
        }
        userLikeCollectionMapper.update(likeCollection);
    }

    @Autowired
    public void setUserLikeCollectionMapper(UserLikeCollectionMapper userLikeCollectionMapper) {
        this.userLikeCollectionMapper = userLikeCollectionMapper;
    }
}
