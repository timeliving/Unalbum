package com.mwh.album.mapper;

import com.mwh.album.model.UserFollow;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserFollowMapper {


    //查找所有关注
/*
    List<UserFollow> findFollowUser(@Param(value = "id") int id);
*/
    List<UserFollow> findByUserId(@Param(value = "userId") int userId);
    UserFollow findByUserIdAndFollowUserId(@Param(value = "userId") int userId
            ,@Param(value = "followUserId") int followUserId);
    int save(UserFollow userFollow);
    int delete(@Param(value = "userId") int userId
            ,@Param(value = "followUserId") int followUserId);

}
