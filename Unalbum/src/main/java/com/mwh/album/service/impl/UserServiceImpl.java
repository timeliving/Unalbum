package com.mwh.album.service.impl;

import com.mwh.album.exception.UserExistException;
import com.mwh.album.mapper.UserMapper;
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
    public void save(User user) throws UserExistException {
        User ur = this.findByUserName(user.getUserName());
        if(ur != null){
            throw new UserExistException("用户名已经存在");
        }else{
            user.setCreateDate(new Date());
            userMapper.save(user);
        }
    }

    public void delete(int id) {
        userMapper.delete(id);
    }

    public void update(User user) {
        userMapper.update(user);
    }

    public List<User> findAll() {
        List<User> users = new ArrayList<User>();
        users = userMapper.findAll();
        return users;
    }

    public User findById(int id) {
        User user = new User();
        user = userMapper.findById(id);
        return user;
    }

    public User findByUserName(String userName) {
        User user = userMapper.findByUserName(userName);
        return user;
    }

    @Resource
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }
}
