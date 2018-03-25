package com.mwh.album.model;
import java.util.Date;
/**
 * User entity.
 * @author mwh
 * @Date 2018年3月5日 23点51分
 */

public class User implements java.io.Serializable {
    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4111152886748923337L;

    private Integer id;                          //用户ID
    private String userName;                     //用户名
    private String password;                     //用户密码
    private Date createDate;                     //用户注册时间
    private String photo;                        //用户图像
    private String userProfile;                  //用户个人简介
    private String userInterests;                //用户个人爱好
    private Role role;                           //用户角色

    // Constructors
    public User() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getUserProfile() {
        return userProfile;
    }

    public void setUserProfile(String userProfile) {
        this.userProfile = userProfile;
    }

    public String getUserInterests() {
        return userInterests;
    }

    public void setUserInterests(String userInterests) {
        this.userInterests = userInterests;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
