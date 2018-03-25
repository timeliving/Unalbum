package com.mwh.album.mapper;

import com.mwh.album.common.PageUtil;
import com.mwh.album.model.Picture;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * Picture mapper.
 * @author mwh
 * @Date 2018年3月12日 16点50分
 */

public interface PictureMapper {

    //查找所有图片
    List<Picture> findAllByPage(@Param(value = "currIndex") int currIndex
            ,@Param(value = "pageSize") int pageSize);

    //按图片ID查找图片
    Picture findById(int id);
    //按图片上传人的ID分页查找
    List<Picture> findByUserIdOrderByPage(@Param(value = "userId") int userId
            ,@Param(value = "currIndex") int currIndex
            ,@Param(value = "pageSize") int pageSize);

    //按图片上传人的ID分页查找
    List<Picture> findByUserIdOrderByPageAndDate(@Param(value = "userId") int userId
            ,@Param(value = "currIndex") int currIndex
            ,@Param(value = "pageSize") int pageSize
            ,@Param(value = "beginDate") Date beginDate
            ,@Param(value = "endDate") Date endDate);

    //按图片类别ID查找所有图片
    List<Picture> findByCategoryID(@Param(value = "picCategory") int picCategory);

    /**
     * 在没有用户登录的情况下展示分类图片
     * @param picCategory
     * @param currIndex
     * @param pageSize
     * @return
     */
    List<Picture> findByCategoryIDOrderByPage(@Param(value = "picCategory") int picCategory
            ,@Param(value = "currIndex") int currIndex
            ,@Param(value = "pageSize") int pageSize);
    //根据图片分类ID查询最新发表的一张图片
    Picture findByDateMostClose(@Param(value = "categoryName") String categoryName);
    //根据图片喜欢数查询每日精选
    List<Picture> findByPictureLikes(@Param(value = "newDate") Date yesterday);

    //新增图片
    int  save(Picture picture);
    //删除图片
    int delete(int id);
    //修改图片
    int update(Picture picture);

    //修改图片喜欢数 +1/-1
    int updatePictureLikes(Picture picture);
    //修改图片收藏数 +1/-1
    int updatePictureCollection(Picture picture);

    int countByCategory(@Param(value = "picCategory") int picCategory);
    int countAll();
    int countByTag(@Param(value = "tagName") String tagName);
    int countByUserId(@Param(value = "userId") int userId);

    int countByDate(@Param(value = "userId") int userId
            ,@Param(value = "beginDate") Date beginDate
            ,@Param(value = "endDate") Date endDate);

}
