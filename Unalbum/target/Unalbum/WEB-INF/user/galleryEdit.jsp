<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/26
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="<%=basePath%>img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="<%=basePath%>css/font.css" charset="UTF-8">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css" charset="UTF-8">
    <link href="<%=basePath%>css/bootstrap.css" charset="UTF-8" rel="stylesheet" />
    <script type="text/javascript" charset="UTF-8" src="<%=basePath%>js/jquery-3.3.1.min.js"></script>
    <script src="/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=basePath%>js/xadmin.js" charset="UTF-8"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="x-body">
    <form class="layui-form">
        <div class="layui-form-item">

            <input type="hidden" id="galleryId" name="id" class="layui-input" value="${gallery.id}">

        </div>

        <div class="layui-form-item">
            <label for="galleryName" class="layui-form-label">
                相册名称
            </label>
            <div class="layui-input-inline">
                <input type="text" id="galleryName" name="name" required=""
                       autocomplete="off" class="layui-input" value="${gallery.galleryName}">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="picURL" class="layui-form-label">
                缩略图
            </label>
            <div class="layui-input-inline">
                <c:if test="${!empty gallery.pagePicture.picURL}">
                    <img src="/${gallery.pagePicture.picURL}" id="picURL" style="width: 100%; vertical-align: middle;"  />
                </c:if>
                <c:if test="${empty gallery.pagePicture.picURL}">
                    <div style="background-color: #f5f5f5">
                    </div>
                </c:if>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="submit" class="layui-form-label">
            </label>
            <button  class="layui-btn" id="submit" lay-filter="add" lay-submit="">
                修改
            </button>
        </div>
    </form>
</div>
<script>

    layui.use(['form','layer'], function(){
        $ = layui.jquery;
        var form = layui.form,layer = layui.layer;
        //监听提交
        form.on('submit(add)', function(){
            var galleryId = $("#galleryId").val();
            var galleryName = $("#galleryName").val();
            var data={};
            data["galleryId"] = galleryId;
            data["galleryName"] = galleryName;
            console.log(data);
            //发异步，把数据提交给后台
            $.ajax({
                type: "POST",
                url: "/gallery/edit",
                contentType:"application/json",
                data: JSON.stringify(data),//参数列表
                dataType:"json",
                success: function(data){
                    //请求正确之后的操作
                    console.log(data);
                    layer.alert("修改成功", {icon: 6},function () {
                        // 获得frame索引
                        var index = parent.layer.getFrameIndex(window.name);
                        //关闭当前frame
                        parent.layer.close(index);
                    });
                    updateUnShareButton(data);
                },
                error: function (data) {
                    alert("修改失败，请重试");
                }
            });
            return false;
        });


    });
</script>

</body>

</html>
