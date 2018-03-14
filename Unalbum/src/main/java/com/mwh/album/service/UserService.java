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

    public void save(User user) throws UserExistException;

    public void delete(int id);

    public void update(User user);

    public List<User> findAll();
    public User findById(int id);
    public User findByUserName(String userName);

}
