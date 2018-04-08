package com.mwh.album.mapper;

import com.mwh.album.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
/**
 * User mapper.
 * @author mwh
 * @Date 2018年3月12日 16点53分
 */
public interface UserMapper {

    //查找所有用户
    List<User> findAll();

    //按用户ID查找用户
    User findById(int id);
    //按用户名查找用户
    User findByUserName(String userName);
    //按用户ID查找用户兴趣爱好
    String findUserInterests(int id);

    //新增用户
    int save(User user);
    //删除用户
    int delete(int id);
    //修改用户个人资料
    int updateProfile(User user);
    //修改用户密码
    int updatePassword(int id, String password);
    //上传个人头像
    int uploadProfile(int id, String photo);

}
