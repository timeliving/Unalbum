<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/26
  Time: 15:06
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
    <title>个人相册</title>
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
          <cite>个人相册</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <button class="btn-default btn" style="color: #286090" onclick="x_admin_show('添加相册','/gallery/add',300,200)"><i class="layui-icon"></i>添加</button>
    <xblock>
        <span class="x-right" style="line-height:40px">最多创建9个相册</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>ID</th>
            <th>相册名称</th>
            <th>创建时间</th>
            <th>相册封面缩略图</th>
            <th>是否分享</th>
            <th>访问相册</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${galleryListByUser}" var="gallery"
                   varStatus="picStatus" begin="0" step="1">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i class="layui-icon">&#xe605;</i></div>
                </td>
                <td>${gallery.id}</td>
                <td>${gallery.galleryName}</td>
                <td>
                    <fmt:formatDate value="${gallery.createDate}" pattern="yyyy-MM-dd  HH:mm:ss"/>
                </td>
                <td>
                    <img src="/${gallery.pagePicture.picURL}" id="picURL" style="width: 100%; vertical-align: middle;"  />
                </td>

                <td class="td-status">
                    <c:if test="${gallery.isShare == 1}">
                        <c:choose>
                            <c:when test="${gallery.galleryName eq '默认相册' or gallery.galleryName eq 'ta的收藏'}">
                                <input type="button" class="layui-btn layui-btn-danger layui-btn-mini"
                                        id="unShare-${gallery.id}" name="${gallery.id}" value="默认分享"/>
                            </c:when>
                            <c:otherwise>
                                <input type="button" class="layui-btn layui-btn-danger layui-btn-mini"
                                       onclick="delShare(this)" id="unShare-${gallery.id}" name="${gallery.id}" value="取消分享"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${gallery.isShare == 0}">
                        <input type="button" class="layui-btn layui-btn-normal layui-btn-mini"
                               onclick="share(this)" id="share-${gallery.id}" name="${gallery.id}" value="分享相册"/>
                    </c:if>
                </td>
                <td class="td-status">
                    <input type="button" class="layui-btn layui-btn-danger layui-btn-mini"
                           onclick="location.href='/gallery/picturesByUserGalleryId?galleryId=${gallery.id}&userId=${gallery.user.id}'"
                           id="galleryId" name="${gallery.galleryName}" value="访问"/>
                </td>
                <td class="td-manage">
                    <a title="编辑" onclick="x_admin_show('编辑','/gallery/edit?galleryId=${gallery.id}', 500, 450)"
                       href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>

                    <a title="删除" onclick="member_del(this,${gallery.id})" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
<script type="text/javascript" src="/js/dcalendar.picker.js"></script>

<script>

    /*用户-删除*/
    function member_del(obj,id){
        data["galleryId"] = id;
        layer.confirm('确认要删除吗？',function(index){
            //发异步删除数据
            $.ajax({
                type: "POST",
                url: "/gallery/delete",
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

    function delShare(obj) {
        var galleryId = $(obj).attr("name");
        var input_unShare_id = $(obj).attr("id");
        var data={};
        data["galleryId"] = galleryId;
        data["input_unShare_id"] = input_unShare_id;
        layer.confirm('确认要取消分享吗？',function(index){
            //捉到所有被选中的，发异步进行删除
            $.ajax({
                type: "POST",
                url: "/gallery/unShare",
                contentType:"application/json",
                data: JSON.stringify(data),//参数列表
                dataType:"json",
                success: function(data){
                    //请求正确之后的操作
                    console.log(data);
                    layer.msg('取消成功', {icon: 1});

                    updateUnShareButton(data);
                },
                error: function (data) {
                    alert("取消失败，请重试");
                }
            });
        });

    }

    function updateUnShareButton(data){
        var input_unShare_id = data["input_unShare_id"];
        var galleryId = data["galleryId"];
        galleryId ="share" + galleryId;
        var unShareButton = document.getElementById(input_unShare_id);
        unShareButton.value = "分享相片";
        unShareButton.setAttribute("id", galleryId);
        unShareButton.setAttribute("onclick", "share(this)");
        removeClass(unShareButton, "layui-btn-danger");
        addClass(unShareButton, "layui-btn-normal");
    }

    function share (obj) {
        var galleryId = $(obj).attr("name");
        var input_share_id = $(obj).attr("id");
        var data={};
        data["galleryId"] = galleryId;
        data["input_share_id"] = input_share_id;
        layer.confirm('确认要分享相册吗？',function(index){
            //捉到所有被选中的，发异步进行删除
            $.ajax({
                type: "POST",
                url: "/gallery/share",
                contentType:"application/json",
                data: JSON.stringify(data),//参数列表
                dataType:"json",
                success: function(data){
                    //请求正确之后的操作
                    console.log(data);
                    layer.msg('分享成功', {icon: 1});

                    updateShareButton(data);
                },
                error: function (data) {
                    alert("分享失败，请重试");
                }
            });
        });
    }

    function updateShareButton(data){
        var input_share_id = data["input_share_id"];
        var galleryId = data["galleryId"];
        galleryId = "unShare" + galleryId;
        var shareButton = document.getElementById(input_share_id);
        shareButton.value = "取消分享";
        shareButton.setAttribute("id", galleryId);
        shareButton.setAttribute("onclick", "delShare(this)");
        removeClass(shareButton, "layui-btn-normal");
        addClass(shareButton, "layui-btn-danger");
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
