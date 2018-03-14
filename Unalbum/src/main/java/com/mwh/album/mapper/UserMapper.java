package com.mwh.album.mapper;

import com.mwh.album.model.User;

import java.util.List;
/**
 * User mapper.
 * @author mwh
 * @Date 2018年3月12日 16点53分
 */
public interface UserMapper {

    //查找所有用户
    public List<User> findAll();
    //按用户ID查找用户
    public User findById(int id);
    //按用户名查找用户
    public User findByUserName(String userName);

    //新增用户
    public int  save(User user);
    //删除用户
    public int delete(int id);
    //修改用户
    public int update(User user);

}
