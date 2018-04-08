package com.mwh.album.service.impl;

import com.mwh.album.exception.UserExistException;
import com.mwh.album.mapper.GalleryMapper;
import com.mwh.album.mapper.PictureMapper;
import com.mwh.album.mapper.UserFollowMapper;
import com.mwh.album.mapper.UserMapper;
import com.mwh.album.model.Gallery;
import com.mwh.album.model.User;
import com.mwh.album.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Service
@Transactional  //此处不再进行创建SqlSession和提交事务，都已交由spring去管理了。
public class UserServiceImpl implements UserService {

    private UserMapper userMapper;
    private GalleryMapper galleryMapper;
    private PictureMapper pictureMapper;
    private UserFollowMapper userFollowMapper;
    public void save(User user) throws UserExistException {
        User ur = this.findByUserName(user.getUserName());
        if(ur != null){
            throw new UserExistException("用户名已经存在");
        }else{
            user.setCreateDate(new Date());
            user.setUserProfile("");
            user.setUserInterests("");
            user.setPhoto("img/user-default-photo.jpg");
            userMapper.save(user);
            Gallery gallery = new Gallery();
            gallery.setPagePicture(pictureMapper.findById(1));
            gallery.setUser(user);
            gallery.setIsShare(1);
            gallery.setCreateDate(new Date());
            gallery.setGalleryName("默认相册");
            galleryMapper.save(gallery);
            gallery.setGalleryName("ta的收藏");
            galleryMapper.save(gallery);
        }
    }

    public void delete(int id) {
        userMapper.delete(id);
    }

    public void updateProfile(User user) {
        User ur = userMapper.findById(user.getId());
        if(user.getUserName() != ur.getUserName()) ur.setUserName(user.getUserName());
        if(user.getUserInterests() != ur.getUserInterests()) ur.setUserInterests(user.getUserInterests());
        if(user.getUserProfile() != ur.getUserProfile()) ur.setUserProfile(user.getUserProfile());
        userMapper.updateProfile(ur);
    }

    public void updatePassword(int id, String password) {
        User ur = userMapper.findById(id);
        if(ur.getPassword() != password) ur.setPassword(password);
        userMapper.updatePassword(id, password);
    }

    public void uploadProfile(int id, String photo){
        User ur = userMapper.findById(id);
        if(ur.getPhoto() != photo) ur.setPhoto(photo);
        userMapper.uploadProfile(id, photo);
    }

    public List<User> findAll() {
        List<User> users = new ArrayList<User>();
        users = userMapper.findAll();
        return users;
    }

    public User findById(int id) {
        User user = userMapper.findById(id);
        return user;
    }

    public User findByUserName(String userName) {
        User user = userMapper.findByUserName(userName);
        if(user == null){
            user = new User();
        }
        return user;
    }

    public List<String> findUserInterests(int id) {
        String userInterests = userMapper.findUserInterests(id);
        String[] interests = userInterests.split(" ");
        List<String> interest = new ArrayList<String>();
        for(String inter : interests){
            interest.add(inter);
        }
        return interest;
    }

    @Resource
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }
    @Resource
    public void setUserFollowMapper(UserFollowMapper userFollowMapper) {
        this.userFollowMapper = userFollowMapper;
    }

    @Resource
    public void setGalleryMapper(GalleryMapper galleryMapper) {
        this.galleryMapper = galleryMapper;
    }
    @Resource
    public void setPictureMapper(PictureMapper pictureMapper) {
        this.pictureMapper = pictureMapper;
    }
}
