package com.mwh.album.model;

import java.util.Date;

public class UserLikeCollection implements java.io.Serializable {

    /**
     * 序列化值
     */
    private static final long serialVersionUID = -547888886748922437L;

    private Integer id;                 //用户喜欢收藏ID
    private User user;                  //对应用户
    private Picture picture;            //对应图片
    private Integer isLike;             //是否喜欢
    private Integer isCollection;       //是否收藏
    private Date createDate;            //创建时间

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Picture getPicture() {
        return picture;
    }

    public void setPicture(Picture picture) {
        this.picture = picture;
    }

    public Integer getIsLike() {
        return isLike;
    }

    public void setIsLike(Integer isLike) {
        this.isLike = isLike;
    }

    public Integer getIsCollection() {
        return isCollection;
    }

    public void setIsCollection(Integer isCollection) {
        this.isCollection = isCollection;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
