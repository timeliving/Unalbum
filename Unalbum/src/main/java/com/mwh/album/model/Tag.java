package com.mwh.album.model;

import java.util.Date;

public class Tag implements java.io.Serializable{

    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4111152885988923337L;

    private Integer id;
    private String tagName;
    private User user;
    private Date createDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
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
}
