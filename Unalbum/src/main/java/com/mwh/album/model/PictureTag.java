package com.mwh.album.model;

import java.util.Date;

public class PictureTag implements java.io.Serializable{

    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4115672886748923337L;

    private Integer id;
    private Integer tagId;
    private Integer pictureId;
    private Date createDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTagId() {
        return tagId;
    }

    public void setTagId(Integer tagId) {
        this.tagId = tagId;
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
