package com.mwh.album.common;

public enum IsIn {

    IN("isIn"),
    NOT_IN("notIn");


    private String nCode;

    // 构造函数，枚举类型只能为私有
    private IsIn(String _nCode) {

        this.nCode = _nCode;

    }

    @Override
    public String toString() {

        return String.valueOf(this.nCode);

    }

}
