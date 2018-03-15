package com.mwh.album.service;

import com.mwh.album.exception.UserExistException;
import com.mwh.album.model.User;

import java.util.List;

/**
 * User service.
 * @author mwh
 * @Date 2018年3月12日 16点57分
 */
public interface UserService {

    void save(User user) throws UserExistException;

    void delete(int id);

    //修改用户个人资料
    void updateProfile(User user);

    //修改用户密码
    void updatePassword(int id, String password);

    //修改用户头像
    void uploadProfile(int id, String photo);
    List<User> findAll();

    User findById(int id);

    User findByUserName(String userName);

}
