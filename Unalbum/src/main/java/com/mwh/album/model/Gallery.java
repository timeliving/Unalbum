package com.mwh.album.model;

import java.util.Date;

public class Gallery implements java.io.Serializable {

    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4111152886748923337L;

    private Integer id;
    private String galleryName;
    private User user;
    private Date createDate;
    private Picture pagePicture;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGalleryName() {
        return galleryName;
    }

    public void setGalleryName(String galleryName) {
        this.galleryName = galleryName;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Picture getPagePicture() {
        return pagePicture;
    }

    public void setPagePicture(Picture pagePicture) {
        this.pagePicture = pagePicture;
    }
}
