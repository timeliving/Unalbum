<%--
  Created by IntelliJ IDEA.
  User: mwh
  Date: 2018/3/22
  Time: 10:38
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
    <title>个人相片</title>
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
        <a href="">相片管理</a>
        <a>
          <cite>个人相片</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="/user/picturesByUserAndDate">
            <input class="layui-input" placeholder="开始日" name="beginDate" id="start">
            <input class="layui-input" placeholder="截止日" name="endDate" id="end">
            <input type="submit" class="layui-btn"  lay-submit="" lay-filter="sreach"/>
        </form>
    </div>
    <xblock>
        <span class="x-right" style="line-height:40px">共有数据：${pageUtil.count} 条</span>
    </xblock>
    <table class="layui-table">
        <thead>
        <tr>
            <th>
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th>ID</th>
            <th>相片名称</th>
            <th>相片类型</th>
            <th>相片地址</th>
            <th>加入时间</th>
            <th>相片喜欢数</th>
            <th>相片收藏数</th>
            <th>相片简介</th>
            <th>是否分享</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageUtil.list}" var="picture"
                   varStatus="picStatus" begin="0" step="1">
        <tr>
            <td>
                <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='2'><i class="layui-icon">&#xe605;</i></div>
            </td>
            <td>${picture.id}</td>
            <td>${picture.picName}</td>
            <td>
                <c:forEach items="${myPictureCategoryList}" begin="0" step="1"
                           var="category" varStatus="categoryStatus">
                    <c:if test="${picStatus.count == categoryStatus.count}">
                        ${category}
                    </c:if>
                </c:forEach>

            </td>
            <td>${picture.picURL}</td>
            <td>
                <fmt:formatDate value="${picture.createDate}" pattern="yyyy-MM-dd  HH:mm:ss"/>
            </td>
            <td>${picture.picLikes}</td>
            <td>${picture.picCollection}</td>
            <td>${picture.picProfile}</td>
            <td class="td-status">
                <c:if test="${picture.isShare == 1}">
                    <input type="button" class="layui-btn layui-btn-danger layui-btn-mini"
                           onclick="delShare(this)" id="unShare" name="${picture.id}" value="取消分享"/>
                </c:if>
                <c:if test="${picture.isShare == 0}">
                    <input type="button" class="layui-btn layui-btn-normal layui-btn-mini"
                           onclick="share(this)" id="share" name="${picture.id}" value="分享相片"/>
                </c:if>
            </td>
            <td class="td-manage">
                <a title="编辑" onclick="x_admin_show('编辑','/user/picture/edit?pictureId=${picture.id}')"
                   href="javascript:;">
                    <i class="layui-icon">&#xe642;</i>
                </a>

                <a title="删除" onclick="member_del(this,${picture.id})" href="javascript:;">
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
                <a class="prev" href="/user/picturesByUser?currIndex=${pageUtil.index-1}">
                    &lt;&lt;
                </a>
            </c:if>
            <c:forEach begin="1" end="${pageUtil.pageNumber}" var="i">
                <c:if test="${pageUtil.index == i}">
                    <span class="current">${i}</span>
                </c:if>
                <c:if test="${pageUtil.index != i}">
                    <a href="/user/picturesByUser?currIndex=${i}" class="num">${i}</a>
                </c:if>
            </c:forEach>
            <c:if test="${pageUtil.index == pageUtil.pageNumber}">
            <span class="current">
                &gt;&gt;
            </span>
            </c:if>
            <c:if test="${pageUtil.index != pageUtil.pageNumber}">
                <a class="next" href="/user/picturesByUser?currIndex=${pageUtil.index+1}">
                    &gt;&gt;
                </a>
            </c:if>
        </div>
    </div>

</div>
<script type="text/javascript" src="/js/dcalendar.picker.js"></script>

<script>
    $('#start').dcalendarpicker({
        format:'yyyy-mm-dd'
    });
    $('#end').dcalendarpicker({
        format:'yyyy-mm-dd'
    });


    /*用户-删除*/
    function member_del(obj,id){
        data["pictureId"] = id;
        layer.confirm('确认要删除吗？',function(index){
            //发异步删除数据
            $.ajax({
                type: "POST",
                url: "/user/picture/delete",
                contentType:"application/json",
                data: JSON.stringify(data),//参数列表
                dataType:"json",
                success: function(data){
                    //请求正确之后的操作
                    console.log(data);
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!',{icon:1,time:1000});

                    updateUnShareButton(data);
                },
                error: function (data) {
                    alert("删除失败，请重试");
                }
            });

        });
    }

    function delShare(obj) {
        var pictureId = $(obj).attr("name");
        var data={};
        data["pictureId"] = pictureId;
        layer.confirm('确认要取消分享吗？',function(index){
            //捉到所有被选中的，发异步进行删除
            $.ajax({
                type: "POST",
                url: "/user/picture/unShare",
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
        var unShareButton = document.getElementById("unShare");
        unShareButton.value = "分享相片";
        unShareButton.setAttribute("id", "share");
        unShareButton.setAttribute("onclick", "share(this)");
        removeClass(unShareButton, "layui-btn-danger");
        addClass(unShareButton, "layui-btn-normal");
    }

    function share (obj) {
        var pictureId = $(obj).attr("name");
        var data={};
        data["pictureId"] = pictureId;
        layer.confirm('确认要分享相片吗？',function(index){
            //捉到所有被选中的，发异步进行删除
            $.ajax({
                type: "POST",
                url: "/user/picture/share",
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
        var shareButton = document.getElementById("share");
        shareButton.value = "取消分享";
        shareButton.setAttribute("id", "unShare");
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