<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/26
  Time: 22:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>相册详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="shortcut icon" href="<%=basePath%>img/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="<%=basePath%>css/font.css">
    <link rel="stylesheet" href="<%=basePath%>css/xadmin.css">
    <link rel="stylesheet" href="/lib/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css"  href="/css/dcalendar.picker.css"/>


    <script type="text/javascript" charset="UTF-8" src="<%=basePath%>js/jquery-3.3.1.min.js"></script>

    <script type="text/javascript" src="/lib/layui/layui.js" charset="UTF-8" ></script>
    <script type="text/javascript" charset="UTF-8" src="<%=basePath%>js/xadmin.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">相册管理</a>
        <a>
          <cite>个人相册</cite>
        </a>
          <a>
          <cite>相册详情</cite>
        </a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <xblock>
        <span class="x-right" style="line-height:40px">最多创建9个相册</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>相册ID</th>
            <th>相片ID</th>
            <th>相片名称</th>
            <th>相片类型</th>
            <th>相册封面缩略图</th>
            <th>相片上传人</th>
            <th>加入时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageUtil.list}" var="gallery">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i class="layui-icon">&#xe605;</i></div>
                </td>
                <td>${gallery.id}</td>
                <td>${gallery.pictureId}</td>
                <td>${gallery.picName}</td>
                <td>
                    <img src="/${gallery.picURL}" id="picURL" style="width: 100%; vertical-align: middle;"  />
                </td>
                <td>${gallery.picCategory}</td>

                <td class="td-status">
                    ${gallery.user.userName}
                </td>
                <td>
                    <fmt:formatDate value="${gallery.createDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td class="td-manage">
                    <a title="删除" onclick="member_del(this,${gallery.id},${gallery.pictureId})" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="page">
        <div>
            <c:if test="${pageUtil.index == 1}">
            <span class="current">
                &lt;&lt;
            </span>
            </c:if>
            <c:if test="${pageUtil.index != 1}">
                <a class="prev" href="/gallery/pictureListByUserGalleryId?galleryId=${galleryId}&currIndex=${pageUtil.index-1}">
                    &lt;&lt;
                </a>
            </c:if>
            <c:forEach begin="1" end="${pageUtil.pageNumber}" var="i">
                <c:if test="${pageUtil.index == i}">
                    <span class="current">${i}</span>
                </c:if>
                <c:if test="${pageUtil.index != i}">
                    <a href="/gallery/pictureListByUserGalleryId?galleryId=${galleryId}&currIndex=${i}" class="num">${i}</a>
                </c:if>
            </c:forEach>
            <c:if test="${pageUtil.index == pageUtil.pageNumber}">
            <span class="current">
                &gt;&gt;
            </span>
            </c:if>
            <c:if test="${pageUtil.index != pageUtil.pageNumber}">
                <a class="next" href="/gallery/pictureListByUserGalleryId?galleryId=${galleryId}&currIndex=${pageUtil.index+1}">
                    &gt;&gt;
                </a>
            </c:if>
        </div>
    </div>

</div>
<script type="text/javascript" src="/js/dcalendar.picker.js"></script>

<script>

    /*用户-删除*/
    function member_del(obj,id,pictureId){
        var data={};
        data["galleryId"] = id;
        data["pictureId"] = pictureId;
        layer.confirm('确认要删除吗？',function(index){
            //发异步删除数据
            $.ajax({
                type: "POST",
                url: "/gallery/picture/delete",
                contentType:"application/json",
                data: JSON.stringify(data),//参数列表
                dataType:"json",
                success: function(data){
                    //请求正确之后的操作
                    console.log(data);
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!',{icon:1,time:1000});
                },
                error: function (data) {
                    alert("删除失败，请重试");
                }
            });
        });
    }
</script>

</body>

</html>

