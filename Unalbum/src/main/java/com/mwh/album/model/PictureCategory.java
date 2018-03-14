package com.mwh.album.model;
/**
 * PictureCategory entity.
 * @author mwh
 * @Date 2018年3月5日 23点56分
 */
public class PictureCategory implements java.io.Serializable {
    /**
     * 序列化值
     */
    private static final long serialVersionUID = -547890886748922437L;

    private Integer id;                         //图片类别ID
    private String categoryName;                //图片类别名称


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
