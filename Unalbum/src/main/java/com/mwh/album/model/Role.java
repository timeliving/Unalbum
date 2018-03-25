package com.mwh.album.model;

public class Role implements java.io.Serializable {
    /**
     * 序列化值
     */
    private static final long serialVersionUID = -4111152886748925687L;

    private Integer id;
    private String roleName;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
