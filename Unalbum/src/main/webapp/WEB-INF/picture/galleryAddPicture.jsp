<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/26
  Time: 10:41
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
    <link rel="stylesheet" href="<%=basePath%>css/unsplash.css" />

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
        <c:forEach items="${galleryListByUser}" var="gallery" step="1" begin="0" varStatus="galleryStatus">
            <div class="layui-form-item">
                <label for="galleryName-${gallery.galleryName}" class="layui-form-label">
                        ${gallery.galleryName}
                </label>
                <div class="layui-input-inline">
                    <c:forEach items="${pictureOfGalleryList}" var="isIn" step="1" begin="0" varStatus="inStatus">
                        <c:if test="${galleryStatus.count == inStatus.count}">
                            <c:if test="${isIn eq 'in'}">
                                <a id="galleryId-${gallery.id}" class=" btn--small btn"
                                   name="${gallery.galleryName}"><i class="layui-icon">&#xe618;</i></a>
                            </c:if>
                            <c:if test="${isIn eq 'notIn'}">
                                <div class="hidden" id="inGallery-${gallery.id}">
                                    <a id="${gallery.id}" class=" btn--small btn"
                                       name="${gallery.galleryName}"><i class="layui-icon">&#xe618;</i></a>
                                </div>
                                <div id="gallery-${gallery.id}">
                                    <a id="${gallery.id}" class=" btn--small btn"
                                       name="${gallery.galleryName}" onclick="addGallery(this, ${picture.id})"><i class="layui-icon">&#xe654;</i></a>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>

    </form>
</div>
<script>
    function addGallery(obj, pictureId) {
        var galleryId = $(obj).attr("id");
        var data={};
        data["galleryId"] = galleryId;
        data["pictureId"] = pictureId;
        $.ajax({
            type: "POST",
            url: "/gallery/addPicture",
            contentType:"application/json",
            data: JSON.stringify(data),//参数列表
            dataType:"json",
            success: function(data){
                //请求正确之后的操作
                console.log(data);

                updateGalleryButton(data);
            },
            error: function (data) {
                alert("加入失败，请重试");
            }
        });
    }

    function updateGalleryButton(data) {
        var div_gallery = data.gallery;
        var div_inGallery = data.inGallery;
        div_gallery = document.getElementById(div_gallery);
        addClass(div_gallery, "hidden");
        div_inGallery = document.getElementById(div_inGallery);
        removeClass(div_inGallery, "hidden");
    }

    function hasClass(element,cName){        //检查class是否存在
        return !!element.className.match(new RegExp('(\\s|^)'+cName+'(\\s|$)'));
    }
    function addClass(element,cName){        //添加一个class
        if(!hasClass(element,cName)){
            element.className +=' '+cName;
        }
    }
    function removeClass(element,cName){        //移除一个class
        if(hasClass(element,cName)){
            element.className = element.className.replace(new RegExp('(\\s|^)'+cName+'(\\s|$)'),' ');
        }
    }
</script>
</body>

</html>