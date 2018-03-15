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
    private Integer picStatus;                  //图片分享状态

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

    public Integer getPicStatus() {
        return picStatus;
    }

    public void setPicStatus(Integer picStatus) {
        this.picStatus = picStatus;
    }
}
