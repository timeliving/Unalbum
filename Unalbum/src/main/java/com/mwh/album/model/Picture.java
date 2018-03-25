package com.mwh.album.model;

import java.util.Date;

/**
 * Picture entity.
 * @author mwh
 * @Date 2018年3月5日 23点53分
 */
public class Picture implements java.io.Serializable {
    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4111152886748922437L;

    private Integer id;                         //图片ID
    private String picName;                     //图片名称
    private Integer picCategory;                //图片类别
    private String picURL;                      //图片URL地址
    private Date createDate;                    //图片上传时间
    private Integer picLikes;                   //图片收获喜欢数
    private Integer picCollection;              //图片收获收藏数
    private User user;                          //图片上传人
    private String picProfile;                  //图片简介
    private Integer isShare;                    //图片是否分享


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }

    public Integer getPicCategory() {
        return picCategory;
    }

    public void setPicCategory(Integer picCategory) {
        this.picCategory = picCategory;
    }

    public String getPicURL() {
        return picURL;
    }

    public void setPicURL(String picURL) {
        this.picURL = picURL;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getPicLikes() {
        return picLikes;
    }

    public void setPicLikes(Integer picLikes) {
        this.picLikes = picLikes;
    }

    public Integer getPicCollection() {
        return picCollection;
    }

    public void setPicCollection(Integer picCollection) {
        this.picCollection = picCollection;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getPicProfile() {
        return picProfile;
    }

    public void setPicProfile(String picProfile) {
        this.picProfile = picProfile;
    }

    public Integer getIsShare() {
        return isShare;
    }

    public void setIsShare(Integer isShare) {
        this.isShare = isShare;
    }
}
