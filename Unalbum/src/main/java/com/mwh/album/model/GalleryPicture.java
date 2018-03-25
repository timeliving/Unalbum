package com.mwh.album.model;

import java.util.Date;

public class GalleryPicture implements  java.io.Serializable {

    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4111152886748924137L;

    private Integer id;
    private Gallery gallery;
    private Integer pictureId;
    private Date createDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Gallery getGallery() {
        return gallery;
    }

    public void setGallery(Gallery gallery) {
        this.gallery = gallery;
    }


    public Integer getPictureId() {
        return pictureId;
    }

    public void setPictureId(Integer pictureId) {
        this.pictureId = pictureId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
