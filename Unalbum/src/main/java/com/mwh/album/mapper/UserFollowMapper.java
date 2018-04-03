package com.mwh.album.mapper;

import com.mwh.album.model.UserFollow;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserFollowMapper {

    List<UserFollow> findByUserId(@Param(value = "userId") int userId);
    UserFollow findByUserIdAndFollowUserId(@Param(value = "userId") int userId
            ,@Param(value = "followUserId") int followUserId);
    int save(UserFollow userFollow);
    int delete(@Param(value = "userId") int userId
            ,@Param(value = "followUserId") int followUserId);

}
