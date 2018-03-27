package com.mwh.album.mapper;

import com.mwh.album.model.Role;
import org.apache.ibatis.annotations.Param;

public interface RoleMapper {

    Role findById(int id);

    Role findByName(@Param(value = "roleName") String roleName);
}
