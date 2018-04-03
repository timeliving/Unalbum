package com.mwh.album.model;

import java.util.Date;

public class UserFollow implements java.io.Serializable {
    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4111152886748925687L;

    private Integer id;
    private User user;
    private User followUser;
    private Date createDate;


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

    public User getFollowUser() {
        return followUser;
    }

    public void setFollowUser(User followUser) {
        this.followUser = followUser;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
